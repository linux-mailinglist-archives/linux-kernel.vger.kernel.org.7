Return-Path: <linux-kernel+bounces-725259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67DAFFC82
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C53E3B481D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EC1293B7D;
	Thu, 10 Jul 2025 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYrq2t8g"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4F28853C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136557; cv=none; b=kno2vafawWN2oxsIswfOhHl20L40j7NyAiNSOEE1/fJOnCHbzNHe/6QhIVA2dIsEZAWq6EVLsxi68ehRgLyXl1uF1JylcTJc0nIdjR9gZ/DjF5Kcsg4A3nt17fKleU3okvbEcPpkCxsJPFenXaU2DRP2Kc6+WorzN2+ZS77V494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136557; c=relaxed/simple;
	bh=A3lDlBL8vvfve4ZfHy4C+bAJ99ewnNr46OUdhSZLiMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U++qURqwc76OGJhkgj4t61DQVro7Z9DvgYMMjOjjKzTwLV/rs13yts+vlOR4RwzJbeCQ3dvsKDhP/W2rRERuYHfbbZylc7tc65oNOlwKLSj+UhHzWMk7hOsh/rM69ExRmIfVoxYiO4KPkvfCQNtBubMerJpa0eEiVX8dq0ZUi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYrq2t8g; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23dc5bcf49eso9393205ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752136555; x=1752741355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh1mmOkigieJ55IHaZfa8Zg2NGfpNAm2HJHID8wzV98=;
        b=BYrq2t8g8NSy8vlfH1ewDJC6hlnme1qgY2UxBHseETB8B3z7bcLKbUzCaA+cYDu/9k
         qElse9V6uJg4ZHS85HC7HmNYyqtMlOmfRZFLN7ctP+LmaI7Y9PqqUgn8Hy31/EUx/qbw
         NIiLuYEePLChQiVGzaj080MBMtp1m09xgubwWQjdSAdzulfBFM1VAzfUUpPKZW7lS7db
         Nf5kvShg/UL/4Y/klPX/fPyZVWux3jMSQKy5I06Y2sdGxHtk1Zf/o+p/3ujZB/wEJxW4
         izlBbFVUKGngl4jbFcfKPxUSDn85V5lPb/SY5zxUJKVqFm5Hmb4t3uT9htoSWeIZSJ0H
         nQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136555; x=1752741355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh1mmOkigieJ55IHaZfa8Zg2NGfpNAm2HJHID8wzV98=;
        b=DuQXgXCL4Q8baKFFgtXHCZTtqLudOpSCA5gHuwKoaQfNhpt+frwdNL4n91N6vckc0D
         EXvrwh9S8NQT1+Is8kTKBwYeYjzI0LkTeDZH5ebM4+YVABS5O1IYlS1R66zleUwY9NSe
         dQarpGtUuNFaIqriE4FHud24sEZyIs6IyMtiTNbAP/uhUoR5Qk2eZ55gdvKFmEVq1L79
         mh9wQkcnXxaHBaTqn62LGxoiwevTzff0TjONAptdm5Ti5vfH58Al4ZtuLPVaSwWNnxYR
         QhXMullSiC7kalgalmGifltq2iyn40eLu2t5lhv7+/tT16EJpX2CWRomTzyxVkeVT/dU
         K7lg==
X-Forwarded-Encrypted: i=1; AJvYcCXcJdTxrjXwBX3p0UoYRnc6lp7HxRGcZEPjgJ1fYh9AtJ+ZiPuFfH6E50i2fFqo8+hEeZPjQInzHBrXABg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZViA8D/w+qWX4xKo8vLKnyJJctFg1XYy6RvZ1hkZUyj/IvYV
	wBAX/FTCnpYlOUXbKfb0bw6bPNEaVBKOwcM9d43QHl0Q8Xl5WKGoC2hB
X-Gm-Gg: ASbGncuam2Goid8QA1hI9AbSq8devB4PYhgfbiVyFNdMZNP/sH10ysOPis+OAUrCMzu
	0p2Gk6MuDzvoBzKFJst95FRGjfYnPtocLbLjZ5Jx2AfKutROBzHl8F8jHV58iAVFJHFfmR611gO
	b06zTewiI082ZmeMtkeihLiIR23HZ9PTZqSircj3tLQsRkZhkWJHbKMsl5NRhgG68mz2RYZLxgK
	hKmtiB5i7SgcThcFOViFQCU6NlQK69Kx5/nsDMVSOdCGVzJqpJXVt3s81BXsdQdud1nsJFRRFXT
	8UyppfEnMT6JHiG0Zi2DZ94bnxev366m18FYFr83L5ddpvGlvrYzo8kAuaqn2ZcndU/v
X-Google-Smtp-Source: AGHT+IG4B7XXAIAZPOLzQw/263sQj8eeyyiKa3sBlRTmcBCPIqhxXPTBdSpDGcnC8CyHrt0iEV3FXw==
X-Received: by 2002:a17:902:e742:b0:23d:ce98:6110 with SMTP id d9443c01a7336-23ddb199090mr86875705ad.10.1752136555100;
        Thu, 10 Jul 2025 01:35:55 -0700 (PDT)
Received: from gmail.com ([115.137.3.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4289274sm13556225ad.43.2025.07.10.01.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:35:54 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:35:49 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Andrew Donnellan <ajd@linux.ibm.com>
Cc: fbarrat@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ocxl: sysfs.c: Replace scnprintf() with sysfs_emit()
Message-ID: <aG97Zdc9YU7QFE-j@gmail.com>
References: <20250710071815.351069-1-seokwoo.chung130@gmail.com>
 <8bda71d7c25900616beb706c73a04bd54830252b.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bda71d7c25900616beb706c73a04bd54830252b.camel@linux.ibm.com>

On Thu, Jul 10, 2025 at 05:23:12PM +1000, Andrew Donnellan wrote:
> On Thu, 2025-07-10 at 16:18 +0900, Ryan Chung wrote:
> > This change uses sysfs_emit() API usage for sysfs 'show'
> > functions as recommended from Documentation/filesystems/sysfs.rst.
> > Intended for safety and consistency.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> 
> An identical patch has already been merged in char-misc-next:
> 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20250620024705.11321-1-ankitchauhan2065@gmail.com/
> 
> 
> Andrew
> 
> -- 
> Andrew Donnellan    OzLabs, ADL Canberra
> ajd@linux.ibm.com   IBM Australia Limited

Thank you. I did not see this.

Best, 
Ryan

