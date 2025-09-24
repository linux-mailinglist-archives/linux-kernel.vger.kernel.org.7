Return-Path: <linux-kernel+bounces-831324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501F1B9C5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C143AC228
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45DA296BC9;
	Wed, 24 Sep 2025 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFlQdmEP"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDAA28851C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752825; cv=none; b=cweIKt4TCvud6s7FA+4vUAxLIHDBF/T1V1a8mQAJfdUqUATOAdAeU55PmIpvJ4x/OW70dRxaB7up2RB8+7h8LUVP9z5dfxKCciNaTLonSyM3UP15dxZUaliJkFXW7GE1goIOkt7IzTYbYXMRUh77rAbGmEI0FS9Cx5/9He2Se5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752825; c=relaxed/simple;
	bh=VBgnju5e4OGNDrwtbMk9Nb6KcJuq+2o3nUneOsF+4fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjQDiTiv19eIISIdTLgtCLGLL+MjXuVHVI4s7OB5pO/EmoK/sl6GvkBby4AI6idbu+87Ai+oaRqc1smf0uKUdrxlUgdsQs2frBTqhTcKKOfgqzfUsAlOXQTnfx65oV83lFTR8xZPle5tuj8a+smU8VJ9x0iJR0rkT6XgaQzdFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFlQdmEP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46cb53c5900so3019995e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758752821; x=1759357621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAAiZ98FjXDGSsUxI+RC9o7W9RElQFrnGJPJA6Tg5jI=;
        b=FFlQdmEP3zBA0Ig3cLBs7dzAnj+LRMDffmWFS9e+1++lQOQ8gaQ/JmInO4DYdvMdWF
         l75JBo+adWKZGyG3yeU0iPBcknHBorfn+QB+xrt3JQkArTFB3LTaKZ/+9A00tLHlF2Dt
         uEaaga4oiwyA/S+QerDBQyfNMm85MTD1LAeR6m/rkD3Fy4oG8aGrfvSAHCqMNSVX3Mxk
         fWC253OvXLA2RwVW7/wYfXdNDgf1Iup5Om4QSEs+hNPkJMBxFk2Z2l3vsVLLHYyHkOSB
         KqBKr4dbDSVdHaHH605UiEmx5IZ2JUqwdJBDnsleQI6jQWdLE+jpUFV6FHyNrY43o595
         Gnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758752821; x=1759357621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAAiZ98FjXDGSsUxI+RC9o7W9RElQFrnGJPJA6Tg5jI=;
        b=Xp1rCpNVztcaOtdeYv5k9uje2C0KmFL3dntNDhUAzVS2a53SA144a+9LycGy1zZbal
         ytrIvjNzxrpGSlRlS1tOFeKFnXOVCdaMfd7p8fFUsNjBWUx0w5bFKp1cR/gptJpcfBc2
         LXY/THqxX0ith8WiP6DL7hxmeAh4PEsDTwrVscXSA9cRSvK0HRc9nq65FMImPXsgRsOA
         i/IzyIIIU5ETmROv3v7AA33OSbxJfEE+g43BAM++6JZ0gpDiGjrQg/Zs6pLM8Fy04Ktq
         Dg1HwTjIbJsDpgLSxtEDZ7DoBta22POs0b2rlwQl4W1UtraUhTIi1ADdRoEs/yr/YTXT
         Jhmw==
X-Forwarded-Encrypted: i=1; AJvYcCWr/sC20kEMoaXWL1ygbRrlSvrzRaXOnp7ywWASFwyMqtqr9sipXpvw9AZNrv0QWYyfA3rvvsmZE0yoc24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMMZpMsCXQIscTASQOzg/0z6q79ewqD34X6koV+lO2NcLW93fV
	3aNu47yK4oMvQhl13fLeokkR6+FMkSGSfZZPtBGzgWluUrtAEnpY1WVD
X-Gm-Gg: ASbGncvHjagTl4ayg8oAOvxB69Z1HBEXsbxN40pA5uhjHQr6teVMGClfBRQx9nv8pQu
	Xo27buzZhhDD8HQl+uEbJQNQw/UO8j9f+9S3t+pEHpTo/+awMgcCjeVH0fOgM+fl6F802SRJxYR
	+3HAJlUxmMMLB5MAE344vVB0+iZOh91BpttZRPqI+End46dhde9QrRw/fzFeXU0aU2730KvDRj7
	WSOhqJnGifx4DEKnjxG3iJu4munHyumT8El10mxJWNp5XzORIvFWZRONOj8B92m9hRNsz6t8qaC
	qmdTIiaNTiV7THjXMsPeEF5xpHsie64DxMHOwuq021w37t/7IhABRZc1i6Fz5JF303S9TDzH1Mm
	Ft45BLVZbDalG0CEn3do=
X-Google-Smtp-Source: AGHT+IG6jyPPpkk8a3aExxGzaFJF8Lv9aP1QB30cWerzfjmW8E0fi6FRCuWa4wt/CAF/bg53qAh34g==
X-Received: by 2002:a05:600c:4187:b0:45b:6b57:5308 with SMTP id 5b1f17b1804b1-46e329a82efmr8699815e9.7.1758752820646;
        Wed, 24 Sep 2025 15:27:00 -0700 (PDT)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33be21casm2735405e9.2.2025.09.24.15.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:26:59 -0700 (PDT)
Date: Wed, 24 Sep 2025 23:26:58 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <dafma6drqvct4wlzcujoysnvjnk6c4ptib4tdtuqt73fcuc5op@efjjn5ajqwts>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>
 <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>
 <aukchuzsfvztulvy4ibpfsw7srpbqm635e24azpcvnlgpmqxjm@e4mm3xoyvnu7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aukchuzsfvztulvy4ibpfsw7srpbqm635e24azpcvnlgpmqxjm@e4mm3xoyvnu7>

Hi Breno,

On Wed, Sep 24, 2025 at 01:26:16AM -0700, Breno Leitao wrote:
> The other option is to always populate the mac during netpoll setup and
> then always resume based on mac. This seems a more precise resume.
>
> In this case, if the device goes to DEACTIVATED, then np.dev_mac will be
> populated, and you only compare it to check if you want to resume it.

This sounds good to me. I've done some initial testing patching __netpoll_setup
to always set np->dev_mac, changing maybe_resume_target to simply compare the
mac as you suggested and seems like this approach works. 

I'll do more testing and analysis to see if I see any issue with the approach. 
If all goes well, I can include these changes in v3. I'll report back in case I
find any problems.

