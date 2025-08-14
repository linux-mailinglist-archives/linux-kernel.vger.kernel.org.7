Return-Path: <linux-kernel+bounces-769154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC626B26AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772141893448
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB01E522;
	Thu, 14 Aug 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KyrQDlp8"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327D215766
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184664; cv=none; b=NijS5zLCIJp/QPQ2hgC8BK0EQzaokiuYCGeyyZT/shyYn+kIKK8sA2hkHdAcucHRALsteVU/QNLAeZkdAqw/v4NZ+zz9nYDCt+SR16ZxAkmrHVcPoYStfyz4ihVFfJzfuGgCg21INrnR1U4PylHISqU1prTBEDUQj68lNS6tEHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184664; c=relaxed/simple;
	bh=jebkRezHI9tnuDesgjFDZKdyprU+i58WH5cbBdDaPds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN0FwarEhtD4bPO+R51VeJs/VEZYbc74quDFXHlZ2KL/arThn0jun0DQNmmXhIiS2ZMO73kSXIdf9Usw2PgeunktTy7BiZnU971tT+I0glKubTMPCBmROKI8Dh0A9slhLtNUq8Zc9yCbLtei+1hEJPj8w6mM4YvaqkV7f5aDME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KyrQDlp8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9dc5c8ee7so754165f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755184660; x=1755789460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bPCyFEVFb9QBBc46MlBjvus9sTU3F14kHpN5YVA+9Y=;
        b=KyrQDlp8x99YWrksEidXMTV7K7LIIYgqnGS7tCf78uwdjONAM4g/oxaOGmxHsQ9H7s
         JFL15sPdfCpnBaNvsdroT9JD0Wo5KntWGveNatjl3/Ewa3mld0Y46ELSCDTY978GR5Aw
         K5vORtFZuBuNOjFC3NPgqggcP98CS3eTr23Ff5tOCIezJg1QwBwFZ73AkGjKGlNjM4Z3
         +u2EsViWn04YHpSm1RV51++MPMMKaJ7Sv5wWtcdsvSS3kSvsXMZ3Or5usW6b4xuzrfDJ
         hB5lpV3ZXx7L8Plhd7rAe4IfOzuCUqB0WP9zEtK85KWyJsbjhnl5PnSVOyeCsa+59kq6
         JdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184660; x=1755789460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bPCyFEVFb9QBBc46MlBjvus9sTU3F14kHpN5YVA+9Y=;
        b=LesjfckedrE3j3thKwbzZngjAGZ0XihflYh0F14ags2qeBSXtl7xbwFARXVXiwoeQM
         b/h8d3jDfHei1BxyBhd5exxCpSVIIn8P0pZc+4NJSm6WyEH9na6W8ZdTvcWkJ7FR64Dz
         PjlC+JxvtS7pNcf7j7ge9YNoxL3iOosH9CAn+CyzIMLekMG7+ss9WtD6HdISiOQI5zH2
         b9DGtNJTa4uHKxteq12ML0NnzeDJv8ATgUb36yk6PyUE/bEPaWGJ1487RBxfMby5LoXH
         EOw/ciWB9/UbveSYNFXqv/9NZeulv5WriNfV6QUu/+SLG7TIPaipP3RBPPXFoNDAD8jw
         /xow==
X-Forwarded-Encrypted: i=1; AJvYcCXfTB1uC89rTETcQfPQhBSL/9h638/VoxF2PDn0gU46ZhxIvKXn9qAcuoQ8PJbXIpZYR89A5CY1d3QZU8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEXKinHKyUeJ/M55hBU9VVV1HzYzv/8t1Ch7IwmH7LuVXYJ53
	QorPN0LslnIjbB4fb5wpfxlih7b5tA64q5lY/5Mpl3fyTjFR5LIgsf4gDxghadLxlpk=
X-Gm-Gg: ASbGnculUBof8attEAu1fQXb2wa/Wyg+XRZK924jKZXiGblf+Z1WxDAzp2S3mbgj/3b
	WsFAGN8ezhecJ93N+KYUqSvJtNSG06pKNupRpPXe/Bs/CWSUj+KUfy85RqhkSzXNZACuy0T9VPH
	pbW5ByptIr6ShHlDkewChcITLk8g4sxTvD0tgO3Lb2lXFzZdybfoHuf2Hgo3g7Elx69yrbhhAdi
	ALA6EKBGc7GzVLSgL4Mm4BYGnI4aZxoE7bLvlakoipOIiO8aj+jqfH+xvyNFmR2BSI30TJHXASn
	YXf7u7lxYA+jTd9weYyvYfDxsrVsE/dnKnUpVohbsSqDDlPn2MExH+GX1vl/XNzpPM2F4qR4VgL
	PPmZ/b6wa4bd0ImWmd1SCNyEKEF8pakpOvbtTo2ZPVg==
X-Google-Smtp-Source: AGHT+IE7suJ0obZmqoydTK2uVUrVJqQaX40zbLZtTWthO0PNMSN/7U4TL/K+YmLBz0Tutg25pJxQ4w==
X-Received: by 2002:a05:6000:230a:b0:3b8:d79a:6a53 with SMTP id ffacd0b85a97d-3b9e4170942mr2609226f8f.23.1755184660517;
        Thu, 14 Aug 2025 08:17:40 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5f2sm353353755ad.125.2025.08.14.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:17:39 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:17:28 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan@huawei.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com, gaoyingjie@uniontech.com
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
Message-ID: <btaaerpdl3bolxbysbqcig6kiccdgsoo32td64sk6yo4m5l5zy@nds6s35p6e6w>
References: <20250722112733.4113237-1-chenridong@huaweicloud.com>
 <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs>
 <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com>
 <htzudoa4cgius7ncus67axelhv3qh6fgjgnvju27fuyw7gimla@uzrta5sfbh2w>
 <4fdf0c5b-54ce-474a-a2c7-8b99322ff30e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nm367fmo4a37tcui"
Content-Disposition: inline
In-Reply-To: <4fdf0c5b-54ce-474a-a2c7-8b99322ff30e@huaweicloud.com>


--nm367fmo4a37tcui
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
MIME-Version: 1.0

Hi Ridong.

On Thu, Jul 31, 2025 at 07:53:02PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
> Have you come up with a better solution for this?
> Would appreciate your thoughts when you have time.

Sorry for taking so long. (Also expect my next response here may be
slow.)
I tried reproducing it with the described LTP tests [1] (to get a better
idea about what and why needs to be offlined) but I cannot bring it to a
hang nor lockdep report. How do you launch the particular LTP tests to
trigger this?

Thanks,
Michal

[1]
while true ; do
	/opt/ltp/testcases/bin/cgroup_fj_function.sh net_cls $pp
	/opt/ltp/testcases/bin/cgroup_fj_function.sh perf_event
done
(with pp both `;` or `&` for concurrent runs, two vCPUs)

--nm367fmo4a37tcui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ3+BgAKCRB+PQLnlNv4
CIdXAP4gJKLPertpfmLD61YAP9Wa1M2wVwhki3vo6TMN3x/24AD+OgODyIBF9VOm
9CJVX35w3E51XyIGiitdzxsuttlz7Aw=
=PZvf
-----END PGP SIGNATURE-----

--nm367fmo4a37tcui--

