Return-Path: <linux-kernel+bounces-818905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F5DB597E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1AF1B28515
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C8F316905;
	Tue, 16 Sep 2025 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w11yYXx+"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A0306B16
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030018; cv=none; b=uGEMqO6h5FD+5MItbnRxYYGe6GQn3GxpdfwDFol13Nlb4CtmiKEKGg01SHowuQxH3XZ7jafZJkm4gCrVwzXx+XH3OqSjFALeBthAai4+KVKPFcvwU8PR9L2yA/Gmh4X22L4CsShXM2GVCLyZ8LqvRAo1cp217LrerM/T2qIR9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030018; c=relaxed/simple;
	bh=+gio5aL+IW3u8W8SSU4aBeYKAREDBl4pvtVMTW2Fww4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHvgI2JA3bGgczJ0XgrSx7MYfB96isfY/I1E7MfsMsXjoLXZSeW0++q2glKRpJ+SPKkWD7SG8SJ4ObL5+F5uQ5mSeXQQnw7d8OmBu4Mb04etKS8fs29tXKORx88+cM7ELnIKLDJr2wQBwLW+mm/+H8mUDUs4kk0IqXlsHYTRdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w11yYXx+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ec4d6ba0cdso891009f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758030015; x=1758634815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcfExlni0fgEhBakaF+iv8wUB2vTkCFI57QVuCuRuQI=;
        b=w11yYXx+PJ2S70aQQE6th1BIImCh6AeKdDLfGNuw5UKqoUlQg24eqiqWzz2LuG36Rr
         St7GLc6KvVp/2vysYpx1BN3l0cAXG/8+P9e80zbhvu/Kg7OAgIdQCFEeLjhmwiKxH+uf
         p7ihY0EUmz0EaHqBp8WcDF9zuLuLyQk+vBrXeBBCcAVU8+lRgrLuFbvDVAgOIpnGq/Qi
         TVC8MIaj7CrgWSh+klvGhsiNYl/1fjByc8yKuEVjD/sDV2EDFt/ZzKKNRqEpI7ky3nTm
         IhtAJC8awvvIPShrMU6xonUvljn1ALrGtZTid0edYRLBXDT+vBY0Tfbmur/QuBe+zHRM
         wSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030015; x=1758634815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcfExlni0fgEhBakaF+iv8wUB2vTkCFI57QVuCuRuQI=;
        b=Py6KK9QNqeF837F6hpRZ2yddb0TRXBzTUFZL7xFq0dlXRAosHufdf25LhOQmRNTcBw
         4BxmbkXI0B37ggo4grJDxtGaR1R6SLxH9h4/FnWVdKHt38D225FgBH6p/vNPJF46usYL
         mXxsuhxPJlwZTy3fDmsFcdR6clk5M90IXuJEDhO31RZxYDNWORYYoX0vXhX3nya8tg33
         2jt6nlJCFJ+0X92u/JmUYtxIfaArnZABKb6W9doFy+Lb4l+yUlnq49nsAlZhSVTXmveC
         h9DWwTwdN1reKGmiFkb4b/mvi1/YvuBnV3CQm2CS1lkquomRs3GuIVnVULrkWW3HUTdk
         5jgA==
X-Forwarded-Encrypted: i=1; AJvYcCVrwGui+CbOdZs4sWjmSXBSpOvcJN8PmnKauKfybxgweCuf7wipXP5qG+9ACvLRQqT1wF0DuSseLCrVShM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67gLg/v+DkVbRmHoRPzNhyRjVm2DvIieRkHho7uBP3wOFIXFS
	pqdCXGi3XvbDOwMIvASWkPyEvP7T9TCNge9E5oeVJm1hRhJwkTCxIzunAhnJT8Z3D4c=
X-Gm-Gg: ASbGncuB2h1QbhPmjVz15wLOvYfUSA5DjWnV33mRY1mnYYy63wdBCTxMUGlZQbaWTxG
	MSUW6uybRZEXP8TJOcmZpy6HAdzaax9bUPKLO9L6ho2VFM0zpCl8HBeSh05Wsy3BZ8JQFZG9fRM
	Giv++haIfU9qhaVlvY0/9w8uNwXaT+o/7OC3JFr47N7jV0QWf/GekjErw69j4QfkCBkeUKx8emh
	Z2tC4Sb3BDkgLjy99wfKUFLrLlmyi3QCJMh8QDPZx/eKX77gYtwr2vEGnqUWo1G9jWubLhPPWYx
	4xhHyMLRfBWsdGlUxKGBtQb+bpdMP4SUKhT9VWiU7jFeUcvhwhGScwzsePIBumPiPqj6gcPX40E
	EMtSxVHRn1kIUfwbw77bB2a3ZiSM=
X-Google-Smtp-Source: AGHT+IG8kaWPMWFHbVd4viKfQeFJBGjRKwC9gr1w5fiYvRQ3T/k+ZTU4DWIxru8SYExw4YHgKkL4Vg==
X-Received: by 2002:a05:6000:2887:b0:3ec:dbcc:8104 with SMTP id ffacd0b85a97d-3ecdbcc8195mr912496f8f.36.1758030014747;
        Tue, 16 Sep 2025 06:40:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f31c51e8dsm41553405e9.1.2025.09.16.06.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:40:14 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:40:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 04/33] block: use extensible_ioctl_valid()
Message-ID: <aMlouk_55OXZv8w5@stanley.mountain>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-4-1a247645cef5@kernel.org>
 <02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk>

Yeah, the:

	if (extensible_ioctl_valid(cmd, FS_IOC_GETLBMD_CAP, LBMD_SIZE_VER0))
		return -ENOIOCTLCMD;

test is inverted...  It should be if (!valid) return instead of if (valid)
return;

regards,
dan carpenter


