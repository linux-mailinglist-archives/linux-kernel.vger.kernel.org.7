Return-Path: <linux-kernel+bounces-830691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EEEB9A4F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A19C16C44A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977803093A1;
	Wed, 24 Sep 2025 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTVQnFUU"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178B1B21BD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724974; cv=none; b=C/tVh3Ze8MgpxKNEQzsfZgUVnIDBsxCD1XA5im7trmg/PO1Wwnd5aOnBSoZGkIudxjT1lWr5Bq0oE199e4IIo5Sf+ZkjBs3zNMVfRment96dSxE+XbPQWv2VnRq4vv76HVLrV0HS0sY3Zv6e0L+ieUmUBD+lOwg6J861bkjr4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724974; c=relaxed/simple;
	bh=Qi99wGIzKeaUad3sDiEcjysh7dML+0H6SlWCfVtNMOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9v3ros02gizm6hlOfnYfan3cYTEtXMDVLw/ihPN48ISEGarU2+WsH1yDAqZAbW4ezeNWrCGirOoz6Y+jpvOc+1MTbJmI6gmoHMTCPfxZkSJOlfPWgertLKPv9seW8PaDvo4VZHOmZqbIrcyVub3r2/j9SGQjbebaVW6HaEWDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTVQnFUU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1164630b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724972; x=1759329772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi99wGIzKeaUad3sDiEcjysh7dML+0H6SlWCfVtNMOQ=;
        b=PTVQnFUU79O8vzgqZhmtnLZh5W+Pt0eadQ4Fi8HeB4uItw4NdFzlljwmzYjmsKgXI6
         WTgCJj88wWhKOQ2XbFxeVvb3onp87FKVMSZ+JcSs4IQ6/eQEwlE6bds3Lrl+Kp0SFnmb
         ZMAbEvESwCROzyLqD2AQtWSBg+Op/MaZoIkU3Gp5GSM3aKSuVWm8d8y5nOclV8/gJY+b
         W+C9uQIe3B0tPsjt9gfFcUHUcu5qAtqGyKrAHGUv4SCSQZnFaZ01Qj83wX0Q40DKixif
         l4G5DSXEALcIIL9sdDAsGIWHk8Y7Ot51SDcGMhF/4ElwxCbAg5vrcZOlFNnm6nwIqVBz
         yKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724972; x=1759329772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi99wGIzKeaUad3sDiEcjysh7dML+0H6SlWCfVtNMOQ=;
        b=OuTk0DtoXtF0rLTwb6i0QBy1Ww0duv/csFPT5aLpm9Z2IoqdNVW2ZmUKGN/ZmT3on2
         T3639bBHHkXQrioCWfHKPcHGOQbtXNMaYfljovQYWSH7GQdv0lvCX9LXXSwBIwqVhb+o
         qAFu7UpSFKJvPW3eXx8hlsM7O/C3WYiLNGKeGkqwdowXgrOHP7jdOmpSKBvhglxSLgKu
         Dozm29GOkD0LvqqTEGXcEpbXZ4MZZkA+UvlMAPABYwBICQWtVehnAab/5JTi+duY3a0P
         zAaaYm6L3OH7ADPYUkY5kjpW1BN9siP/zbw2dyJhLxPPnd8VTj1ETa0nH1tlh28O7Ppe
         KRsA==
X-Forwarded-Encrypted: i=1; AJvYcCXc7w4eJBHtar1sCI2Wha90zTPWx5HySuSyLgJLMYe89sEDhLsjNRQgfjTubrXRt/XrYBdoaVz8rDHo6Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxL5VzQC7yIiJfj3a88jg4OBHtAbraF/TQfvCJabqSCu6UWp2x
	ndDAQ++905WBdhuXJX2frCJ/3j3zMsowSePiJpMzcUumN8GzcspooAIy
X-Gm-Gg: ASbGnctzILAXOjuralOdpi/kTm3Xq/tbhP77xCRmTU6y/qvTyOdfM+CEXRzk1rfLi+U
	y5d8EPUOGQKNBF/OevlgRdTlfGdSb1Td6ywcug4bqunTFYe3q3uiDlKNiXear7m3uAN65Qd6WT1
	NfJtC+IgdHxaxHtRIXVMlNctf2jWB5JcQZB4pwVJAKc1bPInnFK7yKEisynhQ/DP/BNQmxXr5c6
	r7Vwin1q8V0h5kjFsrWSabsK74EIaLmcAiFypB8H4w9ZfNsNKCbBsGTaKrVxruzr3vaDsPxt18Z
	+hXNxhtJnTJuoh9stAoYkpPPoe4uUewt5e3lDC71d6GZUL7mnnihLAL5xbINjkZracoJ7XaDXZl
	eq/zWtA/66N2N3AOa54/Lxq63xuIejDx6MLo=
X-Google-Smtp-Source: AGHT+IGh3h0E81Q1ukwkM0pUlfPxVBz9FgZBOD0oJJn4La63+Ve2DMvTsoHX/t4ygfBSH0SK7iio+Q==
X-Received: by 2002:a05:6a00:2344:b0:77e:eb28:c59d with SMTP id d2e1a72fcca58-77f697803ecmr2756206b3a.5.1758724971968;
        Wed, 24 Sep 2025 07:42:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f61ce72ecsm3233549b3a.23.2025.09.24.07.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:42:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:42:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
Cc: corbet@lwn.net, jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, wyx137120466@gmail.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: add mp5998 driver
Message-ID: <5f651f3e-202b-4406-b438-421489b874db@roeck-us.net>
References: <20250923090926.619-1-Yuxi.Wang@monolithicpower.com>
 <20250923090926.619-3-Yuxi.Wang@monolithicpower.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923090926.619-3-Yuxi.Wang@monolithicpower.com>

On Tue, Sep 23, 2025 at 05:09:25PM +0800, Yuxi Wang wrote:
> Add support for MPS mp5998.
> Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>

A separate patch was submitted adding support for this chip
to the mp5990 driver. I applied that patch instead.

Guenter

