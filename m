Return-Path: <linux-kernel+bounces-819007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3C6B599F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2B41C06625
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1243469FD;
	Tue, 16 Sep 2025 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YZWLfZjB"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9117345724
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032296; cv=none; b=tq7vjGS0h1ok0IZ6TGq+4ta7P54KgLBGnHXR5cAsm/Qh/zB6ojNNG11ymjnZRbK7zUqGg3rOGORYQCXDoQAZkZTtWLP1blTQ/ANnXohr8wiRTPKVKXxAH5R+74WIBBdsFulUb4Ad/8Cgumu2Fn3Kb2s8SqhGjCTLnOmyUiVCPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032296; c=relaxed/simple;
	bh=Octok06lecFOmXbEBeTNHalxoaBEao+jFBDNJCy5+N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDHa021SN9OXdadEmQZYtVp1r9LZlv/90IG/NZmAVuINnN7TRtf2NG8Z5d3Fe81YB/b4AZxrYQZ/wVdjqoTrtvOJhVnEXGSMbiW91dV/SFIkn79hEslijPNObRGMoT8tS76VaNQLyLDhHcxiGgRqWlvuyVyZ6xq/+d70sf0j2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YZWLfZjB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso5091115b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758032294; x=1758637094; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Octok06lecFOmXbEBeTNHalxoaBEao+jFBDNJCy5+N4=;
        b=YZWLfZjBwJX5z6b9zbvM1/RO610lmC1yuNYCeUndhzoIALQQO3XqYsm+wHBoDWAXPO
         0eRoEuNJwMijpCnTTkcKUMxUlvpR9ScSo3gKHm2QAre4QYwmHavb73dEU02jVDsGKrOA
         3NCtJjhX2VARWXMjqQusvfYvThyrGgwJXSTQauqzqiOGHrP76P9FQx1quk7KgOnBPmaW
         iNIZsPWEtxQrJpVvch0QZbyI8Ko0MiuB089ec0GRnY7C+NhM0pFaL7GMes2Mf8JZFE7j
         t9YZK5/mu8hmw+icImfUTtnikUyYXpteR5FthDLrebRHZoDBQD/ocNk990l/YKxNTKCZ
         NU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032294; x=1758637094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Octok06lecFOmXbEBeTNHalxoaBEao+jFBDNJCy5+N4=;
        b=fZK9KruHdOzfeKbV0T1016C2R9+PbTaw++QTsOVoj1AND4Za28x6zDNeagoBn4XRDl
         REceacD76y3EWka8ucCSEyigs76KlNG9GbCCJoO0hPyPCYf7FMx2agy7ZMzKrN2alpWg
         eKxsUGw4WBSeJG+QdvuRnhaxWth6B6iLbR4y1FA2n86kMVoGsQBq0wCOe0pnsaQuyMtV
         NICIuMqXXzOf/HNiecHsQB1jcLSFH2gdsV0FiC6PTZSsc5MXe9Z6cpSWBXg51M68ZNEV
         LmL+U4fe0PRy/HV5aNRlI4ir34ror3gI24ST+ZROmAYdeFSomK90Mv26nbmsS97cQqC8
         M+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5q4jmVcgAYkae0kDgZK1ZnN1PTpv9WA1uDSIft5A4Q9CwEWOojfq4f+VjBVp4MqLdZrXGCXuspVpPoz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykniG8REJYoJ8MIkYdRLvDD057ZaN/KLhT34VsAHwjHBzKuTkK
	dILUsIpDhqjF+PuzjoCkoLfMLsxhnyAA0ce6FZk5cjH0IMJGwFrWTF7AnZCYbg3d6mo=
X-Gm-Gg: ASbGncsLpkgYBObbbUKUtHinG9yKMMn+kpclmq+pFm2Loacie+Vhhk1wBTP3Esf/BPv
	9Mubl071CE62bovf+9GxglvZ1ZUfpK7kjLV+E/CLQ5w4ROdCawUqPGzBH1b7iRwdX3ahYxomIio
	iX4zTL/bGpHBu5zBW3pYbVlmZGj+MRACITmtmqXFmytBqOSlCsKXF3Hj0y8azttljKzCKOLmqWM
	UsxRuBaQzXTVPPZwDaR4ccMBqYFBzErPqqX45N2Kc5SF6RIJtLu+XU30bQ4fqW57nXnaCwoFe3I
	LXvbB2HC0OyArEdPosjigF/a7JSQnM04GZXBx+NaUABt59rnUYTMA0AwO9OtW1Q+meKRbYoC+Cc
	BcfmK3Fw=
X-Google-Smtp-Source: AGHT+IGD5nBLj6v35cTg2tvZ8PlU+OnCQyemsRPKokTRzKRCZ62BJ62/w3yUPzBV5yPLBh7jiX0Slg==
X-Received: by 2002:a05:6a00:1a0a:b0:776:153d:1d87 with SMTP id d2e1a72fcca58-776153d1e9fmr14868406b3a.3.1758032294195;
        Tue, 16 Sep 2025 07:18:14 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b730sm16537050b3a.15.2025.09.16.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:18:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyWVY-00000005RfJ-1tbn;
	Tue, 16 Sep 2025 11:18:12 -0300
Date: Tue, 16 Sep 2025 11:18:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: Leon Romanovsky <leon@kernel.org>, Sean Hefty <shefty@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Jacob Moroni <jmoroni@google.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Message-ID: <20250916141812.GP882933@ziepe.ca>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912100525.531102-1-haakon.bugge@oracle.com>

On Fri, Sep 12, 2025 at 12:05:20PM +0200, Håkon Bugge wrote:
> When the destroy CM ID timeout kicks in, you typically get a storm of
> them which creates a log flooding. Hence, change pr_err() to
> pr_err_ratelimited() in cm_destroy_id_wait_timeout().

Did you figure out why you were getting these? IIRC it signals a ULP
bug and is not expected.

Jason

