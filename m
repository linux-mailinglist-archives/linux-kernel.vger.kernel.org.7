Return-Path: <linux-kernel+bounces-813004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FA0B53F84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2D31C87860
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39591DA55;
	Fri, 12 Sep 2025 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IlRtv3zL"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF964C6E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757637546; cv=none; b=nrvEyDTO1fv+ayqYvub29m8KmSei3ls1i7RNo+Jb9uXEA41tc0Jr/+O7OQOEuJmY4/HcQVdtjioG3u98wjCtFVJbCoPbkvh57tzyAlk+Ex9XgDABVSBm0742p+K+Or4Hfg2P/Vu4WC5J1p7BOjoA4s5ctvLtdbJYIkPXd5cv6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757637546; c=relaxed/simple;
	bh=2VWetjtrxig8JtjKnKwnv3PUIASCuozn6yIHaW6gzMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1k5J6Te/2kLX8xOCjCRZLV+RaxuUIGTUsFSqNjH5G140eRChreSexrOZy8O538MjZBZmE9F8wJIreTTKVCV9L/PLjku/+I3xtaTWk6Zy0lHfuO6Me/bRiTSizxe/S3SwQYXa6NnXAzW1T+JeEsquJXHEyiZgmHVKLMelfriY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IlRtv3zL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32bb1132c11so1848418a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757637544; x=1758242344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pygF7jfRzgyoJR+RbnAP81gGP/4eRj7+xtnD/Gk+w+8=;
        b=IlRtv3zL5X+vFy69DRsWKa/CG2EAq4W6LgBYA8nRLduco7PW/3Cu66Q+54JbvnoncE
         zDbgIR48JD0akO9MuVc7EFpQOKqpRDJmqyCqFKdD4VgfLgQ7hyuphrjVGc5x5BdhqzJ5
         MMT2tnOkyd60oJu7XsuaIK3HQpb1pENRZ1he0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757637544; x=1758242344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pygF7jfRzgyoJR+RbnAP81gGP/4eRj7+xtnD/Gk+w+8=;
        b=rTUXh5ye2mse64vFUQgSpXfmxZpwnGN7YPzQO0oU3Leh0hohHGog+fyREEbo9K9U29
         XyhlFm9Ymyk5yMo5Yu7GjfZOxg/zc7i0XeFArqstpv+1u3jpapTMn1rDReYvFCcQ82KI
         XHc8jB6eQ2WqttRA7wzWPbNaORC6icKjwxhn7pkPet9jfFxGSow+wkF4lD9JNuumK0J4
         GiKNZTsm7Ysp6RxT9NitnWlrb4WT9U3VjYArXyVfRsFysArHrHW0K6P8ZiRiKej31TMG
         zyykrMgKfyBcUbh6OXT1nxsobiE6MrfvT+X1xQphKa/G49X/TXuLk5n0DCIIG3Qkm8tP
         4LIA==
X-Forwarded-Encrypted: i=1; AJvYcCWxjesAqgh+9zbndGIANshmXyco+SGzIQZwF/2TsHPoP+9va8YqFuzHhMCZ97OAL8cQrOT2YpDxNyDdXVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPHf+Xsflb7dL1rqHJ8AC15NbYBwF52aXMq25RFPn6kXzHwrWO
	biQD6B6EONa3tY2h8ZwqHFzXYblgWn0GjtachnmvLTeeH+3BdaZr7AOfpSdIJup21g==
X-Gm-Gg: ASbGncuHADRtd7SAtqpi7zTt2apE7VT3cVa68BA6G9Wmbv6kOnx+KsuVhSvE9uz/ARe
	eCZUq1cyMgDODwSdgQ50SRfz/UFmzze9YRpxl4JV5AJnzSmRo9Rb7AG9xAuycibAB/8lgcAli0h
	2A3IRjowsTnEjxMxafLpGVMWWtmztyOPVzuckFPMzu89prnkqPg0xaxAuAlYaN5Yrhztc8ZmtT0
	DQ+8K2dBce7WTx05TY7FHk+Ehtg11q7Rx/3XwySNs/V/dRrnGQ5nYaeU5ZAcu9nbZQGAWm/HWZQ
	qym30N1U0SrVaTtsrree5vkUNbsM/hMlR7pW274UfUMvyqEvoqJCFfWluPqlzECunH/sRVUBWIY
	J4coBmLUinbbEMXHwP1X38MfsIw==
X-Google-Smtp-Source: AGHT+IHzT3QQNVRvVSz0tE7xG6V0WgOvZURC67BN1xRkbpT5lpSEH+gWhcZm+P+aIDdhInHKfnPrvA==
X-Received: by 2002:a17:90b:582c:b0:32c:7693:1138 with SMTP id 98e67ed59e1d1-32dd1dd8939mr4799954a91.14.1757637544012;
        Thu, 11 Sep 2025 17:39:04 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d93f:86ed:f2c4:218c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b5fasm3501595b3a.16.2025.09.11.17.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 17:39:03 -0700 (PDT)
Date: Fri, 12 Sep 2025 09:38:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <iycnfietmsgggxcdjuqngjuzbuygsxfpvkcz2fwm4frdxin42u@pxhmqcgejnov>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>

Hi Vlastimil,

On (25/09/10 10:01), Vlastimil Babka wrote:
[..]
> +
> +	if (rcu_free)
> +		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
> +}
> +
> +
> +/* needed for kvfree_rcu_barrier() */
> +void flush_all_rcu_sheaves()
> +{

mm/slub.c:3960:27: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
 3960 | void flush_all_rcu_sheaves()
      |                           ^
      |                            void

---

diff --git a/mm/slub.c b/mm/slub.c
index 11ad4173e2f2..a1eae71a0f8c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3955,9 +3955,8 @@ static void flush_rcu_sheaf(struct work_struct *w)
 		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
 }
 
-
 /* needed for kvfree_rcu_barrier() */
-void flush_all_rcu_sheaves()
+void flush_all_rcu_sheaves(void)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slub_flush_work *sfw;

