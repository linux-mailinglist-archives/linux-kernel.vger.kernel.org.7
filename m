Return-Path: <linux-kernel+bounces-788603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D6B38728
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A707B6757
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B724D2FAC08;
	Wed, 27 Aug 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4AK4sp8"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2872627;
	Wed, 27 Aug 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310162; cv=none; b=n+p8+CKkFeBHuot6FsZCG5lwTiQF8CdxKPPfp/IoxtLzhdiMprAQ0TVGusSAphQjCn2wc6LyEkUkPkT/uoi1Vc1SuLTbtdec5Hbt4vJmO9+M4eESmrvP5FYY6OuZXagvOXJHXzqQU2/SqlyKt5b51YtF7FgUPa54hiTOORBasHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310162; c=relaxed/simple;
	bh=eMau+/4qdfaupues2VnmufWJRxOGgqBlK+GKdo5Eh+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0T4UGM4YQXPxvn9ERHgiU0YeiuQlLa0HBkVjO6yE+o3sTYCxfEvDv6AxVdOq49w6WRW3Q9Uh3dTQy3+3eqNk1Evcugh8Mqd7tzIlGSo3yA1/HCneb/mo3ULuPv/ro3jFDKeySEji+HJ69rKbVZNn4mQs7/GbS46udLYUo53/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4AK4sp8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2489acda3bbso6728975ad.1;
        Wed, 27 Aug 2025 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310160; x=1756914960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6W92C0ACMtLtErOfOyXjVV2cNVqglOy8+2tmeSQ1yhk=;
        b=F4AK4sp8av5kmSvjeHzqt5cc580g8PFCYiD141luepcx4YBWqZ0hBkeKZ1ja8Tpcw5
         nVzmoUX8w3ROuHgmYYSlbXxoP1rj1eO43VHG5Q8Ur3FVgCeYV2ISgJBMXMdV0XN0LOty
         bJQB41DpbBker7xa8FG28ITdqCyQMHWGYxlgjcZ6LfFxkb4hrQ0mzB+iREjEzEeJQt4l
         k9rCK882dM7AWmcySXOXeo4C6qxS3GUEi/QgfU4T432RuJ1ncwRqRj9CBxse3tjVtVSq
         bokixzD/d8FrddrD3ONQXEBM4kHIw0GcM8Gluz1S9v+qUsn4dSWoB4BzcA2mJNFNCLna
         2+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310160; x=1756914960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W92C0ACMtLtErOfOyXjVV2cNVqglOy8+2tmeSQ1yhk=;
        b=Y21EZ8sjLOjztLJhPETfwrR5jWvj5l3VCUvAEqCG+QKQCDTx11r+7xLSaqmhy2mi2t
         lRMXEcGI9UnUg2vwBHOnfHxjryHKJivgHUiVCmtzrh0TEBa8/zTrY6ZhfLdTlqnlRV9q
         mkmkEPUwRLACg7aS+CbHIDlFnNSy3YUY4w53y/7AMiDMs7a3Ir+f6+r9sYFEBgsZE4F5
         upOcovU6hdPtlRjoWWvatJgcyMseEghuuExDCcnmG58d/9/ePd1CAx1Tcp3ecuHRv0sY
         Y2vDjJX7j73gzm/z+YtKWDcJP/ouAmBJOmTSRoI2PoJzQmT7cjsKf9KCLUfZUyGnKesN
         +AUg==
X-Forwarded-Encrypted: i=1; AJvYcCViakBr/DUBplDX09kYAygQYGd1/7+IXxzajxNo2VZPRjLNWE/crEK4o5vJz77speh4vEaLySxseGb9lw==@vger.kernel.org, AJvYcCX/anwfb3fZpfTDZOEnSF6Y6bMsSatuJWea/xLQvBs+U4gnnhteA5ZaOyVFUWXPrWa3xKYzM3dtttJ8ayFJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDkLwRcHlAl8/rEQT0jnmbdmu70CYykiDDyrxTWrRq76aFI1E
	Eguy9NC+ldW/Sl3p0HV0yhO2aoZEzvlyEpSlzUYEAXtX+yl+Qte6OJeF
X-Gm-Gg: ASbGncucfRpsN7cqe7Zify8Igvo3eyrUdZ+dfi2VkqHM+IkLPishXJnDBN6P+cIWssS
	9NZ+NxfzVPSE2G3rkCMYaASddX4ZZ+pUNlC8zlAWxwCO9NAkgFBm1Hk9Kp82hExQW0P82ZCYjEK
	7p4hKQH+EJU4Wn4Ny3nh1VVHr1vFlio/zAq4GitaLd8qXo6aKw5XWlBihm5kJVNHHRcaDtkrmxk
	ImRqG0mII1pJiYdAFMNTJzIE3ZjZSsBkiunxmZ9ML9U7MKdlAwzdDZ5bS8DY2rcLDLg/cLGfQUh
	bx1NJcOjKMTU6e99APdtChGvjVyvcp0qFism4+aDtrwV3Pd7EJ7EegQkiQdgkgQoKdHU55BIBmU
	vFwtbNWIQHGK6sz5xZonAc2ARu/yK5QCVqzuxL94dUmRzUQ==
X-Google-Smtp-Source: AGHT+IEU49MlNXvhLpAYwIlxunCJd4JoZWN1DqE5aTbE1be8H/nGnxUXlnl1n2y/ZUy5w7dbZyOvhw==
X-Received: by 2002:a17:903:2406:b0:248:8872:5889 with SMTP id d9443c01a7336-24888725c49mr71756505ad.38.1756310160062;
        Wed, 27 Aug 2025 08:56:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24879b2a23fsm39546705ad.74.2025.08.27.08.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:55:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Aug 2025 08:55:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Rong Zhang <i@rong.moe>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jean Delvare <jdelvare@suse.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (k10temp) Add device ID for Strix Halo
Message-ID: <25317a14-3bd9-4ce8-b708-410385217f9a@roeck-us.net>
References: <20250823180443.85512-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823180443.85512-1-i@rong.moe>

On Sun, Aug 24, 2025 at 02:04:41AM +0800, Rong Zhang wrote:
> The device ID of Strix Halo Data Fabric Function 3 has been in the tree
> since commit 0e640f0a47d8 ("x86/amd_nb: Add new PCI IDs for AMD family
> 0x1a"), but is somehow missing from k10temp_id_table.
> 
> Add it so that it works out of the box.
> 
> Tested on Beelink GTR9 Pro Mini PC.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Applied.

Guenter

