Return-Path: <linux-kernel+bounces-752723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 433E3B17A32
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391356257D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A3728A40E;
	Thu, 31 Jul 2025 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2ZOh7BL"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F128A400;
	Thu, 31 Jul 2025 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005545; cv=none; b=RX3LblMUgNmBhybqIaq5RYehpu/Q/t+ZNUHvrdUNeT84vsRTJQp3CP6fk0obXfj1/FjJxb+QRxdkT/ZqeBYXr3RdnbjgcmkvLz9PjVyJ3R0ErPvmxvlLKCeFShME06+EsWJE9nNWUh6MpH4IIM5BDqXORbwJcVqh1vtqZjCcEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005545; c=relaxed/simple;
	bh=4D2EJV9voW+9SlPmR2xw32558C1NnSNyEM33QHMV9gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOH8faXUt4GPIZ+3Cup3gq4yP4SJcz+TJ3/jGGCNHg/kBD7BkQVV4fKcAiP1QsncPshOipEbftVLwxMOq6/PkarP48g5uu5a3M94XTY1VPp8Gizs5kALTZRsYbnTGYhWf0IoMQSziF0FkNdN06rgKopjbUea7A5uedZeGCQ02W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2ZOh7BL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2402bbb4bf3so3780905ad.2;
        Thu, 31 Jul 2025 16:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754005542; x=1754610342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yex/ydJXdzg/rN78zfDzyT3liO+Zgu8J0mIXhG6lyE4=;
        b=B2ZOh7BLTMiVkKoRmGSF5sZ9KFDDhALJgFX4r0suw21USgy5l4/+oACTdlQ2LCTSnA
         Ga8PLnZYqLQQPRMfhf1+5pb5VFpup4vP4m9Eus2+ZOeNHdo+IvF9buuQ7dmSCJS9Sp8/
         yZMSw3ZYO6XOIDae+8peAAEXRnALlZc9v6d+mfls733Lg6E5dcBmdgHeLKKcQU6Sq752
         jCNl05d6kdWsVLHMQK8hU7i3f1ft/7GVnDPJ45+oJJ2Kn50LXUTzJg8yA8bdi6bZYMmP
         q4uLBuw2ZHokmuk8t+YS8yR+DMEf7/6aIm78Eqf02XfGpatP7Wb3GQUglEL2sa/PUwRO
         B+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754005542; x=1754610342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yex/ydJXdzg/rN78zfDzyT3liO+Zgu8J0mIXhG6lyE4=;
        b=Aua7fEckB/dbZ+NbBdZB/HQTs1FTNwZ46Q5/0NeJVGEH7mnsBxnrbKXhoJf/my3Vz5
         EmmUGZneI3UcfTNSd9yno3rA4KP4hiEkdDdF1jW+P2yw4Ha++dzxQiS6gNTep1c2+1ox
         RLXvbDsEeLb2a8RWFc53kn02hBTIRJB5Ui6xdpaOEmMnvuCDgLBE/sBrihaIgpNHPPVN
         ulnR06O2drLrjJ4jnztmNhKbBvjfWFllwxsP+8yYcOWZWfPgHGLp2jBHGaQ6kBOvM1p8
         dEb378chHpPOXSb4zXLTOSibHxl50HMn8AP6Rb18bGG8208gdEU3cNqdgquv5g4DAeKQ
         Y8iw==
X-Forwarded-Encrypted: i=1; AJvYcCVXmXNz8DX4Mm7Gp8YNkrv2VfBF+KcNoi8wbCit0LuWeRG3kPPjBzIT60Sast016rmjGaxkZaXebGI=@vger.kernel.org, AJvYcCXHVwKkRQobvcyNaKQ6N5Wl4Iq1066ck1sKxRYjDaDlNqs++PtBXinlHYYkk/L0x0PQVoZ9Df7Cq1ciPhD4@vger.kernel.org, AJvYcCXZm6Jj5bHOf/iPs5dktl13gGDtVPaXUgLbLyeuJzK+7fwdRG2x5yqL98AIAsfkJx6FdX1TCISXkkk/CBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MEl1w9MBBjb89dE6PIub2cbXfB2Z7RAQTxMQCRPxkMSF0L2T
	6rhOX+gyAUMk1hqZ61/OVb1XwN2NmocnrbJG22Nw7D+xjvxzdj26iNgu
X-Gm-Gg: ASbGncv40sUP13Z7bgVb/yHb4FMOnkUeyu3xxOk1sI1qZNNOf3e4Bn06G4kIff3mAg7
	KbLwxUjKFJiS/ZgCW0Yb9t2hnWT1fckyWW/rlrFpOWRz7cmHXWWoE0ea9X+OGFV9TtWGe0hZNPy
	x6T8Qm2Ilfkz3O+wUJn/YV2M/Icl0OMS/eD2Osgs5t9qxxfGu9TefouPE3ag0Bq5p0qljL/jOM6
	A2XSDnGrV7mL7EAlO9IU4eROzOuFQXDD+1jrTrhkLghIlw+7FYxrpWwRK6zzm+rO6e1qeqtk9EG
	9yvfr236lfsjOQHQNqiKQbr5K9kjTJjxu/+a1Sbd3MAag7Db9WZu1nSCYVWTZazW0HM7Bb061XT
	QRgu238Gn7lJAfpdZK36oAtR0hyLZIsrgQ5E/BQbANwiLfQ==
X-Google-Smtp-Source: AGHT+IHxy4Kj0XhqMS7yfeiDtsq2vpReD6BNhMg6hiY2qZI3D2hLL3cZjonGvocJxs7kMFGX/QujbQ==
X-Received: by 2002:a17:902:d2c6:b0:242:29e1:38f0 with SMTP id d9443c01a7336-24229e139c1mr10281375ad.24.1754005542462;
        Thu, 31 Jul 2025 16:45:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a917sm27851475ad.116.2025.07.31.16.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:45:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 31 Jul 2025 16:45:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Dylan Tackoor <mynameisdylantackoor@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (asus-ec-sensors) add B650E-I
Message-ID: <b90b184e-60ee-4270-9197-68e72283b97f@roeck-us.net>
References: <20250728205133.15487-1-eugene.shalygin@gmail.com>
 <20250728205133.15487-3-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728205133.15487-3-eugene.shalygin@gmail.com>

On Mon, Jul 28, 2025 at 10:49:09PM +0200, Eugene Shalygin wrote:
> From: Dylan Tackoor <mynameisdylantackoor@gmail.com>
> 
> Adds support for the B650E-I board

For the future: s/Adds/Add/

I fixed that up, just a note.

> 
> Signed-off-by: Dylan Tackoor <mynameisdylantackoor@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

