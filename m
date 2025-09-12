Return-Path: <linux-kernel+bounces-814173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD09B55038
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4075F189C620
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD4930E853;
	Fri, 12 Sep 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l53DPv4j"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1A131E49
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685716; cv=none; b=H2QXFwr3scegS3rVj+I2i6XZYOcBZET2+0rMooIxF35Zx33Hmp4RlKKrl/GapSMgFr7432bUwQK1Otp0WTpgWWru4o2vXxgtylYM7gJwczaEdnfXnYJSyuWd1Z75mdzKU3wH4Zb6cinhoXLkKp/XezqVYsPKAlgnSnbyiyfVXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685716; c=relaxed/simple;
	bh=7rvcuIfSUk0LQQCXax61QkLh1aDxQ2GxeV04u/xOeLs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=hiEItli8ySLFxYl1ncwTIRgw9mzE7GvMrL0yVgZZGQMurMPNeneAjI08kK6XfJsLpfXkK4foH8UZkmVCqgKA35nTL7N1YDcqWrk7ZZolwng4HLLnLmCFE2wQYAFnnwmF4Xde0zvMoPIa3r507QEkZdeA0t9bfYLYCbtAg/5H9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l53DPv4j; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32de096bf8aso1474136a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757685714; x=1758290514; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rvcuIfSUk0LQQCXax61QkLh1aDxQ2GxeV04u/xOeLs=;
        b=l53DPv4jNYtrmAX/f8v/XCF2JCWuz8llnuOBx9UWQNeADMCb8NuusWd/xQ7ODL774j
         zKvwB+cVvx8UFuBe1wSctSv5SHYujp2qP7kDIT4b+p+dDzJx4Gvh9IYslHGuvdjGmsOw
         /AQlEqgQ2EE+TK0DLopA3khV4R+9RIBbj6U5JNxyfFkv5KkITI3TNlcuLithU1P1AFDL
         6pjQEXOA0BAfytNSscV5emKruw6lrOGMrdFCbwAVvOHuHd+AFiG2HTKYHOfCHbVgTRgz
         N2AFcPEx0d5QicwDwpidIlCVS11euzuA1Gce0BMUA7GAuWkDjU9u1QPojHzDzYtYsVz7
         KX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685714; x=1758290514;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7rvcuIfSUk0LQQCXax61QkLh1aDxQ2GxeV04u/xOeLs=;
        b=QXYOOuKuXwwyB5EerIl8+SrcuM6D4n2nGS4Ib+cKTNqUmNDnmkowlv4jFA3X9Vw1K0
         3XpUsGCU+0IW0e9ekqK4bzzF2NQKMc7mbbumEcNdLBTpMbLZ8Z7nI/SeHz3EvX1ru9yU
         zkvu7680u7lGRLkwHSGLp7TDKYEvMHWZtLVrxNsXOU5SZ1ARtkav6D5zl3sI3BL70wK/
         42kd+h/B/eDdpY4iRMOz7qs73d1DGOYNocHIKvZX0mwhOSn/VtLMkyxiIIkcJ/T7httO
         Xm36F3VDavrU334S2C0Pp31YgYkurzd2VwnILUQPyxVoPA/1OhjzPbUPHTzGOHYLzMWH
         uJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyoEU+VV2mYGVWH2jlitQ/pUnjq0gC80S9qXRAy2kVdADCJq4QwhA83NMIChbUO596uBm7+emSO6u6ihY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAawcydWFvVmMvQ+niDdr4gwDZBWDEJ/AQVEIUGb4U6RF4GqvM
	h2Gnys+xDDDsz8IDv4XB0kk6faU2sLmxbkpCrb1tw4d5XroBsNjfCZP5
X-Gm-Gg: ASbGncuFvzkLK58z4CUTlQSWj5kG0FjW9Jo/zWg74L0p6axO7LcnuibPiDI7Nig+dDo
	26Lk+EthnU2WT9dpqKF2BMrW6o36bQI4zi4Yld3o3T57+KFQFWdI3x7Yee+ghtB1fZI4deSvTKz
	3tofgO0AuP+gvuOkt03SPl/cgh0f4TTTxgVJ/gVGTq0/bK8EsFdxUPVqON4X4HUdGVfXDsnbXT8
	/QRnWHDB/b1DBKefKlo7iVqgckFoV3O4SNR3fV86+NWOMC3Lv9CCyMlmNCDh4J7jF9xJhKonZlf
	CpCu7eOMKK/dfhh7k0J1/8xwMByzq6zPa+sf9G5eyVifcmKqX4WIqizt+8YarvY95UlLgdtpUrt
	d9XXLsjYPpHHecoYDdqtFTBgvrs+kLH7OKnwmWU+svMRkdKdLjrCJvP4QMrBqZGQ=
X-Google-Smtp-Source: AGHT+IHWSz+w6eoIkvhvgrVNiWjU3LYGlW7OOlG0NTY3CL+0l389umh5tpWV5rzuBp8pVkhE0o6IIg==
X-Received: by 2002:a17:90b:3504:b0:32b:51ab:5d3d with SMTP id 98e67ed59e1d1-32de5165dfbmr3662440a91.37.1757685713515;
        Fri, 12 Sep 2025 07:01:53 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b3e8fsm5885506a91.17.2025.09.12.07.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 23:01:48 +0900
Message-Id: <DCQVKZ3LKK11.50FS0CMR7ARL@gmail.com>
Subject: Re: [PATCH net] net: natsemi: fix `rx_dropped` double accounting on
 `netif_rx()` failure
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250911053310.15966-2-yyyynoom@gmail.com>
 <20250912132123.GB30363@horms.kernel.org>
In-Reply-To: <20250912132123.GB30363@horms.kernel.org>

On Fri Sep 12, 2025 at 10:21 PM KST, Simon Horman wrote:
>
> Thanks for your patch,
>
Thank you very much for your review, Simon :)

> Thinking out loud: Adding use of ndev->stats to drivers that don't alread=
y
> do so is discouraged. But here, an existing use is being fixed. And I agr=
ee
> it is a fix. So this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
I also noticed that many drivers are still using `ndev->stats`.
If I work on related changes in the future, I will make sure to use
`struct rtnl_link_stats64` instaed and post patches accordingly.

