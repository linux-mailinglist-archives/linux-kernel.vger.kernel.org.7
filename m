Return-Path: <linux-kernel+bounces-828175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D952BB941B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D4804E2AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BDC258EEF;
	Tue, 23 Sep 2025 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OHg+a34F"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D063A1CD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598152; cv=none; b=dfsCX302jotkcnuUnvl6QCq6fzusxeTXJ3Q6ua+QxAGYq7NGSi1y+a1ZvsKHJI1NN8YhsNZAU+jXE5sbdlHxq8SrZQJb468NvW+U30OCtHvZ+LgK4qWBhc0TRd/B0ByQ/N463zK2XMqQfXEIEWb15DQw2+sys8LI/ZOFTiztLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598152; c=relaxed/simple;
	bh=EXwzx+jqaKv7lifaMmXXEYRnm1eiubi1vxbrL8+Liog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9qDH5r19hMTDVttO/Oauo3bYBDiXyRoyl22q4uXH9nP5TYgX3TwjORvfWl5XuNRY3eNXH200XZXiyH12fCJwmcmbrJlnxdNoZQgIb4qwPNNk6zMs8yjObqV5MYMGALwV8CmkupvvG1zo057pAC+D+UK852b/wjwCAgualzJAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OHg+a34F; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8877b60f7a5so186146339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758598150; x=1759202950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXwzx+jqaKv7lifaMmXXEYRnm1eiubi1vxbrL8+Liog=;
        b=OHg+a34F7gBNu2ln4g7T5ELLoqz3SFDECE3JAY73bh9zSNypV1NwXD9LKPIrfPvp0A
         US3QilXd+5TAy/oxA4KPelP5X3ofIk1IhtMRdhCx0FwyaiJrIuEjt4lpMqoyUZuXCekz
         Y8or8qUXxgro2LcFTqSWBZkgc1/kjqWlQTe7Z/qytpKM9sO7V2fZA2SzI2ypKh6bEPbU
         jJPoBMeQwzMmEaIbnbq8vPUAVEzl1Ufv8Orm/rnIGkTEe5Zx8igsGABnvY1PITE8remi
         n1DKSa1gi9QHXViMb9QRpMUXli8bc8u3tJZt5Ua8Ja0Obh1/wMyUc/eS5vble7p2zSlx
         Yn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758598150; x=1759202950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXwzx+jqaKv7lifaMmXXEYRnm1eiubi1vxbrL8+Liog=;
        b=WxtXSSH7tbj+SPd3fsWqsVfw1lf+2SzHpVN/Yx4uBNdMu/Utku/8zPj34Be4FOXOa6
         HD/fP2YSEYN/HROm9BukGaiaupOPf27Qb8l/MPm31Op1m+A9hAhJb9X3CcX0OSJIXy1K
         AuwyZuerM1hobUmeZC4awTxHlwBcsTblR03vlqISPoSeOumAOli7QJuoY2ZTDuO3vmda
         G8qmhUHEKjSrb4Lw8vDh/b0U1QAkFvpr57lU39f50RRsgBVO2EiycC8oj9BlFM1PaaX3
         jJoLchzi6zYl0ObrqDcFNDOQJeIDJWpA9NyWGytPWDSydA9oTe7GGiNbYmLUa8i7OCiq
         q/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV/3PVZp+Vlre2JBlvOOBIyC1noot7Truv3xVZkWSTdDMTUa+urWq/lDqXXKqCbZMSCqiUD79cq4XHHMMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5J1w5xf3AJ/aaaDQJB+p1xYEyBS/qLABrTHh1U7BWwpNDnRFL
	DqThIoTw0QgnR+p6oI/78pzyRWndyTmt+s1ALgq28lrn1oVJ1X/gESDGQAir863bAV8=
X-Gm-Gg: ASbGncus2xQG7G4sK5YyKW/5iRnmq79fa2lKNrxhZ39FV6tPEnc2l03y76jb6QMDhUv
	u03bvIFbEb4RAT7mh4lRrBIj3pdTJmBAHWLi7UIN7pgfJWbf/PG7eUOUjc/FBgBpZZ3/XRhGYwV
	O/o9Desx7EETXWv52+VnD9/0aQs11RvcKrNz8RbpwYw7AbuNL/5N3mgUt3Hkx+13r5NWbk+dt+N
	aC591SUk6kSuDoTWxa6n8m8WYDPv6x3ZsGRKLr+0O/2ihnNrQ+uPArkaWcpoU9gbvcO0fw6gDXl
	LbadFKClp3VB/6p6A06GFLtauz3x3Zc3O7vq2NOt5jlQRjgVCIxAJQsZpM9RSQ0v3D5aQ6F5uw9
	iQTroLXLIHd7gW7yB/c5bx/xUIjWQWi1shO61bUIuJZ9U8cv4X1W/zvr7dgoZQq0pZuWsDRkxx9
	I=
X-Google-Smtp-Source: AGHT+IEFnoJ47e7b8X7FUCgUXJFp+M6HEk8QQku8r2B40eiA6Wxiefxrlh1a4+99394BsiieDEPFQw==
X-Received: by 2002:a05:6602:2cc6:b0:896:fcb5:4ba3 with SMTP id ca18e2360f4ac-8e1c4800940mr291928639f.4.1758598150200;
        Mon, 22 Sep 2025 20:29:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46b2f3cdasm503126939f.4.2025.09.22.20.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 20:29:09 -0700 (PDT)
Date: Mon, 22 Sep 2025 23:29:07 -0400
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 00/23] Enable CXL PCIe Port Protocol Error handling
 and logging
Message-ID: <aNIUAy6VbNdSzplJ@gourry-fedora-PF4VCD3F>
References: <20250827013539.903682-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>

On Tue, Aug 26, 2025 at 08:35:15PM -0500, Terry Bowman wrote:
> This patchset adds CXL Protocol Error handling for CXL Ports and updates CXL
> Endpoints (EP) handling. Previous versions of this series can be found here:
> https://lore.kernel.org/linux-cxl/20250626224252.1415009-1-terry.bowman@amd.com/
>

I know there's still some in-flight work, but for the series so far:

Tested-by: Gregory Price <gourry@gourry.net>

Please ping me if major logical rework gets done and i'll roll through it again.

