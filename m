Return-Path: <linux-kernel+bounces-895566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF909C4E4B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AA93AAD1F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E7A307499;
	Tue, 11 Nov 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LgO0m2jH"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B3303C96
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869709; cv=none; b=Ajh2haL+uN12LDxDj5aYY9SPskvqVKaqT3gekPYW7p7ezNtEfIVT8X4MHe2N/yXAWv3lM2H4edA3yYDa4XSI0tOEO+b/mHDM2zpM3VklVsx72Mc1dZ9Maztxx4wx+Zu8RSWq02qjHgcbZtqgzuJWHzr75vXY9xZaU+4pGVzn3rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869709; c=relaxed/simple;
	bh=KMzpcEkWVzPwJOALZcd5Z38NN7WAXyzUhqVifBdo8RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYetbCUh9ppgVj6FLPcvMgfG7FD3j13WuwXErHIWUKWOVKTW19FbZdkfSQGyowaxUNsae95W1jB3jDDo9tiX/VElHdjx4GxhwHJNkqb7o+FbceQZigCK/Zg9HI6ckeJ4V6704KGmHqa60NusXanqb+49vEOnLXkfRm+Vgjztbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LgO0m2jH; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8824888ce97so30479716d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762869705; x=1763474505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVIlbaArLD+xEsJRTgweLsSstkPgQPx6U1v6mUAh+wQ=;
        b=LgO0m2jH5gRmBfTq3ouXolP/anXHVuWs5qK0vAC5ByrETiRazeFQx0BB0v8+9Sse4w
         aHlc6NgrMc6sHiQnUyaXXmwcDER0vXvKB1nqzEYKRGs94Wa2kfBF3d1CWQkNeS84vZOV
         3WxcPHeMNIpky5rJUJT09Z/cmFt+eXf7nQXfgy0LWpEBY7AGa//V4nyBjWS1DP56eB9W
         4CxGm4UKpAacET54Ik8oRIe0d0Pl0JKjQoBhj9/1s4B988AIYQr7y5IOUkk8+Dcv+SYJ
         cF2x+/KVE9j0718s6xZ/rIg5Ku6VNnPlIt+WL9ZQsWGmcxz7907TaDStYi69ZWd2uZI+
         MQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869705; x=1763474505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVIlbaArLD+xEsJRTgweLsSstkPgQPx6U1v6mUAh+wQ=;
        b=C3M1YquqfmJXgnjg4r68ML+SBvOzwazCbsJWCXthc+6X3Kdh80lqA1egZrFWyHPowJ
         IieuqOFwpDSqe/AGBR0CiyvoBSDpLImb25wXFa5mFfgydDk6mB8o7pzM3pL9jSaLR6Iy
         FB3PL0PP9c0Bds2DFBIV+OqB+ctJFdJVg1pWfQewjCx1jJmTqnmGyMdprgkQSDO1OftC
         diC15i06R19JaKVx/9nCrdLo750IWpzdZO4Mg2AC+FnofHpE2lH+GUj4vuHmdBBJ4N0L
         sHVKyG1P+Gmfk2VuHhhQP75u5IYUr2CIYE1rjmryOIbmVQ1W8HaX+MvLcuqXfKYSl8ur
         RTmw==
X-Forwarded-Encrypted: i=1; AJvYcCUWmztecMbBNb4tHCNGQXTplZPFxiga3oOLe6j1GqvQvYfI0HaEvqtNDKoUU6EYFur1o3YQRd2vf++Wzsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3IgP1gqkOmAw16tjKThPhdn2d1rI4lab0r20fGvsIJeSZy90
	41yDGESwoygp3djUnZKd4HQgB2ZUgJM6ix59PLwU3X6KLBxH7gwegf2RLHUeEqPSvF4=
X-Gm-Gg: ASbGncuMc2/RHqzti8r2rVMEfEWcXdf41Zb1vxxh1VBD8twpfD6DRGTkHgZsR4Y3OTt
	DRnD7IPcjYy7tVdR6Jvv0JA8cBqYeTwyLIKyWiDddfmAM0uhYtGGD5U3WD1GwcS9dxYfHctYX9T
	lq1JUW5NMy4ZL8ehR+cFt9nihBBvlEKaFtc0dDzsSbRskYyX9Wi1icUOBFT/xOTU70N+3mCLTLH
	mxuK7JCKuZwfSV439XciF/071PFmPACjV4DuP83LI6s/iIbMaDMNyNiMgeaUjXi2GtcUgK0ot0F
	CHdWwgp7ybjvdh3/uanHTEROzpy9aBlu6umiIp+Rgj3sSkvqvYI0jDGT9ALDopYeFLKBUix1nAJ
	mpwSe3y5N0m66jR87ANU2T9+X8RIjIduRRHb5xZt0pb0wM9whMaSBNrSeaO4mEuxPPvzjbxEeBF
	U3jvPKzggNqwdM0UbjU4Nm3omb9gnrtxAeMm++v8guHnAKGUB/AiUMwCXpEW/hiYpW9KygUQ==
X-Google-Smtp-Source: AGHT+IFWbPEXPWLzIkOWVIuQ03hw2eJ8p8ZC0z6FbQbFz3rRhv7LpdqZn+aAf49WvkXXdHfZGzUa0Q==
X-Received: by 2002:a05:6214:cc4:b0:880:480c:6051 with SMTP id 6a1803df08f44-882385eeba3mr152689066d6.5.1762869704944;
        Tue, 11 Nov 2025 06:01:44 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88263830feesm11249586d6.36.2025.11.11.06.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:01:43 -0800 (PST)
Date: Tue, 11 Nov 2025 09:01:42 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 00/14] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aRNBxlZhxWlaNL2P@gourry-fedora-PF4VCD3F>
References: <20251103184804.509762-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103184804.509762-1-rrichter@amd.com>

On Mon, Nov 03, 2025 at 07:47:41PM +0100, Robert Richter wrote:
> This patch set adds support for address translation using ACPI PRM and
> enables this for AMD Zen5 platforms. This is another new appoach in
> response to earlier attempts to implement CXL address translation:
> 
>  * v1: [1] and the comments on it, esp. Dan's [2],
>  * v2: [3] and comments on [4], esp. Dave's [5]
>  * v3: [6] and comments on it, esp. Dave's [7]
> 

Have been testing this on my Zen5 systems backported to v6.16 with
Terry's updated PCIe set as well and everything looks stable.

Tested-by: Gregory Price <gourry@gourry.net>

