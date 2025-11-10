Return-Path: <linux-kernel+bounces-894303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97100C49B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E561888D66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8582F747D;
	Mon, 10 Nov 2025 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DERuaMvx"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA3B21C194
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816560; cv=none; b=STyMP4oqwtTwMy5r0ykMdcPA0vEEuXKf1JxA0THSkZf0S0BlAQ5oqyOLGddOoZLIb7JdThNWYAUKH/dkw7B7NfPM4aBQlgQaOcxPmnANMc72lOYe4C/D7/wTJkUPMG7N7Q/1gre4m9Sy3qBXnfMarEY9v7WAOH3KBjo9HEc687Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816560; c=relaxed/simple;
	bh=h5TTiI/L91Gy+XLFx/Zl3KrvUTe7SfQYuWBRrcnVR54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekf81mREVdXKNOy37B87eZRLeyNMd3vCuDHcdq5sNHP9SYjWYKUCt2ibkiEfxj5ru3eiiDoVBx13wU+Te2UmBAVMD8jPmO3vK6AkVdwb9CMLMx3b1jmXqj7TVuxXXVw6Tj6QeKMFwCJ9Z0NOyFfVUVD/z6G+/+XI2tyS7OJ48cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DERuaMvx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2957850c63bso2855775ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762816558; x=1763421358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTCBfyjKL85nI7lncbdUck6wtAuHEbruuMTez3UdOuA=;
        b=DERuaMvx4XwTvfn4aCMWr74Rj+wFrQbzox5lH6uq9HCJMjMsVRuba7ar8ka8MHemmo
         UpqHqmgi5xhtdky+1fE8K33yw3cKczDTbdgECGdZ9aQINbmykbd6VWlLGDQE+Knxp3pK
         GxEyRxP+BM07SYEPtKkkY/V2VeG9JWQhxO45Q80DKG6HYrLjioUD39KsNvmp1R9b112Z
         UjSOIxMpLb48ILikt2AL02ml3msWq1vCqgoVEOADE/07I6lqZ/YFdbIhz86XysKoQy4t
         Ui0PEbzt+40oYIkJXAXr+4Cnf/J425zG/fan7nxgtUKYfWVQiCUlpQ9mVANzLbuUwf1X
         /xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762816558; x=1763421358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTCBfyjKL85nI7lncbdUck6wtAuHEbruuMTez3UdOuA=;
        b=Sa0eq0crDyxBBYhjHtIeNxMUCzCUScjxQcCzH5SULN803DWlEmsmWPCZ9SNv6O3vx9
         1KzqDVztAl9gc87LFDhHIBVy/6U0u/dKNwVbpjuJsjKQig4ilVbx44A4Fwlwzd0YE7uo
         MLXNozbE5Az1iVDgPE/695oI501zjwdeixAOO5UFiXJ//wJ5WQSEI9jzSSFy2XWcVCTE
         IcpCzYIQaoS0Skh21O/ZHcSjBd6lBCwY6aw42Uf+P8CrhBKJn+9gW7/fAh+Hld3HZEf6
         j1s0mk5Ru/VNzjNSfvz0ng8nk3Fc2KFHcIN7YvoQCvBS43HQzlSwoXXbiEIFAkjMGpsj
         yYYA==
X-Forwarded-Encrypted: i=1; AJvYcCXolf16MCGIjAxQuAAQSP57VG8uqN9VKFWdWioU19xJGXY1B4o6hWmwy8DnNsmTKC2nig8ixSeiSi0k96I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEdHHGuUi/OrKgjY2f0bojNnG0DXMDQ1qqGgX6UlB+lCscRzkx
	19w0szNLLE5BPTkcF1K+F6iLsxkYR2Eri4c808ec+qVL2ql+BHQ4o++8
X-Gm-Gg: ASbGnctqY8cuZEGjFViF+wglI/c9TvaStqGbyD+tTSTQW5ubvs6Lj2cO7vPDBp9N3aP
	EgrENVN5PYlsDhC2OAm7j2nQuiUra70aoyIdxuruHYjwL4nEnKm3oTDFIoIiUyN5nV37jWr7q7h
	45xCVrqNFkjYCzh2VBNysr2vVXgdl/9AkA/8CemHdu2msqX2d6LuCMSYPlHV9Fqdb4oU5ZEPAvX
	NSv8IDOPXDWQV1CfRsDvQZNFEaM4pCzlDABxrRtEPwRUv9CB9ukBh7kY8T8HRGG8qQyLXj1o+3R
	kR7jRR51qh+ctTbtZEUc4YJ2YnzaO7bR0/H0Gb2WhTl+QDONEEwQt3ewsoSI6UqihI15tb9WYGd
	WnqJi1qWMLgGdjnncZE0psurix6lzytdSX3PXsRvEVvGqx2BCww7AD9G/OEfFE8KBlkVJv2HP94
	J7
X-Google-Smtp-Source: AGHT+IGwvLf3ZgdUd4iAsN+CriZ8KUEaW9yxRhFdFBiIvi5V0uUTvjVhxvMH6yq504eeDgLltAEolQ==
X-Received: by 2002:a17:903:18d:b0:297:df99:6bd4 with SMTP id d9443c01a7336-29840842cb3mr12574055ad.18.1762816557960;
        Mon, 10 Nov 2025 15:15:57 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29836cce339sm25144965ad.59.2025.11.10.15.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:15:57 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 34C6A4206925; Tue, 11 Nov 2025 06:15:55 +0700 (WIB)
Date: Tue, 11 Nov 2025 06:15:54 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ARM MSM <linux-arm-msm@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
	Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Aswin Venkatesan <aswivenk@qti.qualcomm.com>
Subject: Re: [PATCH 0/2] accel/qaic documentation fixes
Message-ID: <aRJyKlRkihq1OcGk@archie.me>
References: <20251110035952.25778-2-bagasdotme@gmail.com>
 <e44c8f40-b6ff-4369-8d86-ded225b41544@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e44c8f40-b6ff-4369-8d86-ded225b41544@oss.qualcomm.com>

On Mon, Nov 10, 2025 at 11:54:59AM -0700, Jeff Hugo wrote:
> Thank you for the fixes. Yet again I am impressed by having your fixes in my
> inbox before I even see the reports.
> 
> I'll get these merged to drm-misc-next where the offending issues currently
> reside.  I anticipate getting that done later today.

Thank you for the compliment!

-- 
An old man doll... just what I always wanted! - Clara

