Return-Path: <linux-kernel+bounces-793575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4D1B3D564
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 23:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3158173B95
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231FC23F26A;
	Sun, 31 Aug 2025 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSeHyyRa"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F0C170A37
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756676544; cv=none; b=cgLOnLL9N2ntXLdFN92+gaasEWvPHd7myuhDNjw6R++CSycuhFayNoWO/HZrtDncYqe1T1I3JJU46KzX/3WAQpHkOZ46qE4ReFQuJMkGJQK9TrT0+8gNacho5xe/VS/WXasXBcRIUWe71zOJNzi1D0WTau2KtxeggKWSp4UqUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756676544; c=relaxed/simple;
	bh=XrWnjGupWDAHdXimUfuC/NSyB9S8VAE4YTcPqsyV2zU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqOiG7ne4I48UmNUKIiexW0eP6jp8Ddel5ItMQxWZP2pvzWNMx8yDRftd/mVCVtjA9wBcqPFlZfy1v4GVPMiYnqxUGpB1U78lPADvSLM66/e6JB5XWzm5uYhnDgJDjKIPl5Px65945y4ckYip4dZqNDx4SX542SFcuXBSSbE/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSeHyyRa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3d1bf79d6afso943838f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 14:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756676541; x=1757281341; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XrWnjGupWDAHdXimUfuC/NSyB9S8VAE4YTcPqsyV2zU=;
        b=hSeHyyRaO8TNWVcakL7qALdqskLTKgF8a70nJrV81PYMGUWTKpZKFryGSHOmmInaLP
         nG7ljTko0rTHLBx4RGT08qhQ16cY12v+nR+ao6HSOPbQPrOpH3hcAlJ7BkU+6QYGEl8b
         CpHXcjm/Lgim9HEW5jCC8eVOK1JwVxYAxa96m5I8DRoXlgLvuA5g6kqRinFaVc1wdAp4
         8AgloO+NJzKlrqp5sSlGFBEhsTZenfVmwnw9jiM47KxxiHI92gRzxLcdjubZj3qpLn//
         qjWPVoOnywpt+wje6U6B4+BNRzTCL55pHB4UplX3N9oKyN332f9RUVP8FWnllQVZt/IS
         EJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756676541; x=1757281341;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrWnjGupWDAHdXimUfuC/NSyB9S8VAE4YTcPqsyV2zU=;
        b=GVndnmX2IzxX0eVVblWIZ236/N1zDbVRYHesnoAYokkxrkFO4tLzW5HzYOcB1oOlgH
         sfGm7KRRnbcSE9BGuWRUgelPnP9aV7Xh6xx6Ljq1RKMumU4e9UyW67ZYSnZNcAxyliPS
         8CGj49wdx0T2aTo7RSUnr6owc8q0Cm+DMqwOErOutQJjCj7J2b4QVw8fZaJ6rty2UVxk
         zSun+Yk8PHvlSWzUr/01aeBeDATiwDUrx5KaMxke+aAbQEpXmn98ko4JtLWmqyfnFGz6
         KxcMsH2iTJW2KsD3RGKgDbwbbKJMhmpk1g+pai4L9hlr34k24t2c5feVUL1GeBzU5g9g
         w/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY9tKXdRKe383U+5zJgrztVqnaeul0iEJz8cPQRNwvfYtLZ+uzzWcMR+hTmMAe9uYKqhsui0Y+9nBlQio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXd2dzTI/Q/V0bQMp4psdrBDlF7/2i+5ozdhjAqunTqJwSi5cV
	5tApcWjnF7aSs3os9klmT1bfVKsqUedi3PX1/kNCTNotvnEajtdNtYzX
X-Gm-Gg: ASbGnctsCg+fnL9f+RAhfrg3qb9CYPuxynEYMBT8jbGcqS6bxmTI0D0/leAhbAhWTh7
	Sce2CYphe3J7BK+XWShqD+60CfNGq5eGGRukiYmqmIYBuT6cjuzL7GfKslONEnD9MXKGnXdwAuX
	RBLbkqwkz6hIVU/4i9J2xjnMnbqfaqU/EFx/gBZ/dPa8EfrZnI09UQpJh87hMOSA4ADEesqSQ1a
	x5OVk8k3WYysmJODXXRR90pJHOrB2g/gDNmTEKJ3aJNU2KrNUlcigkuuhM0aKKYM2xlRFIW6s6J
	p5sBHwtwHaaGeld6N8vqqvgm5WdIl9swQYizdSQ8Sh1nyCeHdU9JVkoD2R97M2EyzFKRuSmYoPt
	iXusLjLGZVv36uSJta3obHYi9QoERYqZitQx66IDwSMJyekDRjwKH96KswldveXwkbIS/PAIaO6
	kKBnoH/wCeW0mMC0O/r4l6O5Sw1TLatYkClt7CO79J1azw0NmjcKrDRAc0mofHWPWSBMT0nuDJ
X-Google-Smtp-Source: AGHT+IEcpg8XF4kOOyrGus10eY7b1mwm4xr5kWKrRe8C/RxRerNfYyIyHxVayFHtIZ1srX+bh6hP3Q==
X-Received: by 2002:a05:6000:2007:b0:3cf:3477:6bb7 with SMTP id ffacd0b85a97d-3d1e0a9424cmr5087701f8f.60.1756676541056;
        Sun, 31 Aug 2025 14:42:21 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24c1:9400:d6ab:39bc:9d60:a351? (20014C4E24C19400D6AB39BC9D60A351.dsl.pool.telekom.hu. [2001:4c4e:24c1:9400:d6ab:39bc:9d60:a351])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b69b7529asm127855375e9.0.2025.08.31.14.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 14:42:20 -0700 (PDT)
Message-ID: <14a9ed202a304fe895719f406633e79fe16e8535.camel@gmail.com>
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Borislav Petkov <bp@alien8.de>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
  Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Sun, 31 Aug 2025 23:42:19 +0200
In-Reply-To: <20250830174810.GAaLM5WkiFc2BtQ6kW@fat_crate.local>
References: <20250829171655.GBaLHgh3VOvuM1UfJg@fat_crate.local>
	 <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>
	 <20250829194044.GCaLICPKJcGJRYdSfO@fat_crate.local>
	 <20250829204840.GEaLISKGTwuScnDF8Y@fat_crate.local>
	 <CADnq5_MbpYmC2PSyOr0gQk7F8mVz0-LG3dZtUZS2HhV8LTgDww@mail.gmail.com>
	 <20250830174810.GAaLM5WkiFc2BtQ6kW@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-30 at 19:48 +0200, Borislav Petkov wrote:
>=20
>=20
> With newer MESA (version 9.0.2 in Debian), the message


Which Mesa version do you use exactly?
Are you sure that version number is correct?

Mesa 9.0.2 was released on January 22nd, 2013, more than 12 years ago.

Timur

