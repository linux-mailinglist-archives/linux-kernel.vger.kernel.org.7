Return-Path: <linux-kernel+bounces-849660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C4BD099C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54CA3AAF5E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC12F1FC2;
	Sun, 12 Oct 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpkcvHz/"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88562EFD95
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292755; cv=none; b=RV/Xlm3Pc8hzLNLO+DkimitLZn77+cQpLw/0KxRY3d3Bh5ARDhYm6YuSafhFNsJChl/2X30n1VaMe/5SmSlV01foPduUn/ICNRJJknnAts79z8CSQ0cCT8d2ZTGig+Q+rQivpYwhW0k6CTDw7T5Xr/bF2+x0wl7s81V5I0uxupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292755; c=relaxed/simple;
	bh=wktS8hk5SdONpr7hDtnum8JkZBzGQGtSnk+ZlarPI74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZpTyxc17dt65URFiUVwj8x0XCWIA4DIObq6vDpKQDOTdvbv3Cf3VTNINC25yyu3x3MbJdX/ThwySLPl8BfL2FbYykrRJZACtPXoXlK0PHskahzDZ34cj/yCFBU1uiXyt4mJr/S2kjCyvvOW4wdwzegobzP4cu0tAtBYHGoVV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpkcvHz/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so2149123a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292753; x=1760897553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VC8GXXSQpIv/LKtCgeHxQw5d2s/g3mf02Ku+jqIhxz8=;
        b=MpkcvHz/IelBtULM9/eV1l5nDHrJVxbX0fLvplEH/dYq+k3UKStAxCsl5b7HevAzPJ
         mqK9qEijclCHchOkQ6BZEZWyM8pYaLWoHSQSBBEdg+27TlFY0+P28ifi1Zt9wK5TWS7Q
         8fPmft4rT8OmMPaG/2iRVEUGreTlJGPpWb2lpB7BTogFO8wzoi5kjJmx3Y3od7zPaYdA
         Lnr54u9aVj6hJ9qSNOmh1P6tIxCT9PMASerrHjYocdqk4364qLBn14SghrlblT65hIEO
         Iessb4Wj7kD7q/SlLiXDtkMpa7hkGKIOMxDlEvQqMUXOEeJs85FhhbB0pyRYcPXbWLr4
         xTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292753; x=1760897553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VC8GXXSQpIv/LKtCgeHxQw5d2s/g3mf02Ku+jqIhxz8=;
        b=uJYgjU7ZvB3hMl1Epo/xMksSFQuY7Olg1Cl2KvQOD8pZzpatUCb/mjm+deWXoOdANd
         vFGJoftaT7fA8aB/SnmqF9dq/+szshoL4HA/rlJ3znZEU0hSyMjflr/V+vhYx1Vih/EB
         EJuwBKCsMv5eW0+vZZLFqUSa+/0EjhSRNEAJXvmGb6cE5QU3jo1k/zy19Ky5EQu/HiqK
         vBStkJ1DKIv1ZqJ9ZLBPgP6uuDmnp5GPDDI260YSLxZaGG0QL9xyWtiscqiGzhHO+FZq
         tWSpZ8n1ONbHMG7NUqJ+i/hZCPVzHTRSqoLjWDDfwp6SE/PUsWrbf7X6XYkhWn4PEMSZ
         BewQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpP/YeT6lEp/JWcwvlMVfi/HabYbvLNgaRQcukbsK3yiaS0PK+GyTR1Q9vB9DqIBEPvDHYiaqWZbboo38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLxFvZq7QvU9lhS+DBr0EIHTJylUEIfUbxikLbzmrmA3bp08le
	ClJWgufwx+k/DoRffMZNu433yfXMNokBvnFcEC8QbAL7xOwj1vmA/WYr
X-Gm-Gg: ASbGncuK6EdZiAmGDozdL7V222R4nJAglEhl5IRL7pNsN1roeEavqhQyCZXPYINCZp6
	w00EGJ5GPnsssFUp5/wcaGREm9Aw7JJwvWBKAZ7f01AmTdoF7AWs3E4AgbIUK6K/dIUmxonzFcS
	ihVLshVa6gxgIRX3S82VxqTU+y+s2p+FzR3EtFqc8NcpGXUSeCckB3KE67934SNQ52X70gDitj9
	Cj5PM4eJRxV6nQCRkMGPDlHGVpjS+4IEuZ05pLR16xO7Vq6O/SzOo3HrtWY6ranT+Kf2y2qnoUi
	qTen5rsUvYdBMEcpjty+55RZCNtXmpk8DUmmXs77gZiZnQ4VjQbgLXmwHSqb7dIoTYU4TV+ndL2
	gU68cb9qj4ViBCmmwyKny3YtzelGoZII+mcWJbJXWTO5b5zHMIT3Mhh6YONOYhAUA
X-Google-Smtp-Source: AGHT+IEGCa6rp5AY25/sXZIN5SM/UqExUQocFllSvQfqN7W2GP0rr3zSmTZkdcqeZqOv2pX50YTOYw==
X-Received: by 2002:a17:903:2d1:b0:24c:965a:f97e with SMTP id d9443c01a7336-29027356aa7mr255105745ad.2.1760292753291;
        Sun, 12 Oct 2025 11:12:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de9febsm112201485ad.7.2025.10.12.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:12:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 12 Oct 2025 11:12:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/3] hwmon: (peci/dimmtemp) add Intel Emerald Rapids
 platform support
Message-ID: <da2e5d5e-4bd7-46a8-a664-2f5e0d69b28d@roeck-us.net>
References: <20251006215321.5036-1-fr0st61te@gmail.com>
 <20251006215321.5036-3-fr0st61te@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006215321.5036-3-fr0st61te@gmail.com>

On Tue, Oct 07, 2025 at 12:53:20AM +0300, Ivan Mikhaylov wrote:
> Extend the functionality of hwmon (peci/dimmtemp) for Emerald Rapids
> platform.
> 
> The patch has been tested on a 5S system with 16 DIMMs installed.
> Verified read of DIMM temperature thresholds & temperature.
> 
> Using Sapphire's callbacks about getting thresholds because it's same
> platform/socket.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied to hwmon-next.

Thanks,
Guenter

