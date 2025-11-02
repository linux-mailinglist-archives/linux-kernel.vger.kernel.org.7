Return-Path: <linux-kernel+bounces-881975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2703BC295B5
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 20:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45BD24E82EF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 19:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435941E98E3;
	Sun,  2 Nov 2025 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTgFnqAn"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578079F2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762110262; cv=none; b=m6SyTglNXnBFRK/uMt+4U+2P371I/amc+tLcojX+U0ehHg5k1+q20nZ82lG4kwi9N5841atFthBngj/vp7AsYdFuRzNEak7Ppnm/w/SFZdZPV66Ghj6F6YugLn8guX+CYzpuTjlWtFSn3qLcIq4RNg2BIJxe4Vv+PuO22WYXk/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762110262; c=relaxed/simple;
	bh=dOs4gbMporl3UZegOSJ19pjsXgAASYDpHErFCO/+SmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFYHqxNjMgoYH09mF3OeW8S8r0b6aOpWAj3m4OXsSXG/0H1SCDCb+VMWRW62ThZT7t1CuG4JzhAa0JBc2JQhaa5M6lpZb7ssEqkKF628IE+P5cuKtRC6T3IXXKCv0jR0iJ2xJesT/+0l1qbA7FqbFCHHjiyDAi/pdG6NFnAdc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTgFnqAn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so4629810b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 11:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762110260; x=1762715060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bEBvdKdcxlFX6ebzJy0mu/otoDYrSmrnQYrDh7FFC4=;
        b=HTgFnqAncVjVs6lSmEALM1+/VUzNFbxXQfdjfbVPq6JsQWxDFBPPWUj4f08MnQe7vt
         5aQUVjDGohvPIIra4fhdKlPd+iFvyD+AmBVopIliShP9tmw+07LCo8eCWhON/AlfBSde
         GTHLpOPqToHQEuHfrSPuAPPBCVr68yMOdVPhStEpWAsmnrOJ4DwSLhBW1/aSJl1EF8lB
         0KJ09NUWZuisv69mbYsWSG0mI6W77mJYRcP/t1mSo6NFba6v/am8PpJ+AdY5ToJNUP7C
         2bWHofTULE//fKgdyxHLjYZO5e8c5IMvInYjXx+IKbUWsa5KkcX54wyLc3ZCgNsv+Gan
         c+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762110260; x=1762715060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bEBvdKdcxlFX6ebzJy0mu/otoDYrSmrnQYrDh7FFC4=;
        b=rvj+U+VrGu1vQw7btzS9+1RKh+KV2JJ6m1QGpihPlIjcTvtBMkHyA2K1QeZxsByN5z
         Tz3GYAI3Cb5mcnfPswMYJ6yaoo6SdOqZuhkXtRqTR9rwbneDL77v77qf2tddbxrIlTcf
         iMRnHObvFyaPBMboueQo+1wc5785S7Bzwf61YYU2XxBf5wRVr2yp4HsS4fcJ86/Dcglw
         QH7ImU6qZ9f+Ed8DCWkE0rqH964MiqMElQnH89Wu/sXeve830JNFb+0iW6GqheJiPUku
         nKrCxGka4Kbl+q74P44SrwwL7z4+Am6/vOwApBa3rSe5lWT/VdXKB/hm0TPKPxyqIgfA
         8BIg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Xsn2Rn4M8Cxe+V7ntX6c1AaT9J5mX7N1p2vneGdl5xOMOM+1YZf0aWOzDJZCaQ8OegMre1AWTXeE+aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMOIp8PehCc9MnI2CdJWX1AyHnayKYDsG5sRYfSJLwfxnwOvW
	odjaBtrWUUMkfoSeaaylJIsTZw2oFSoIHETidfx6E590TNfS8yrUO3tq
X-Gm-Gg: ASbGncvW0ta0C4OwcVH42bp8fZzw2nsoW6W2znrEmSkmo9qaUlFTKiafclIv7/DhHx4
	cf44oskIrnVfXjv3fozJfbCDbWqh20CP2h6t+UHMxOiX08ym4uwR6eF+/K32tTE+3BQvGj12oRP
	GGvJSolJpKPqvUKjMpCg4GqgyPL15+88udWateIM+5jRqeFYncQ6Vw4KAyZ5J7it5pKxUIgH2BZ
	fxurl1kKHjyaG9YgRnHVBycaPTLqnf1GWoKHEaLUmyWNgnVDwDR8nMC9ofVkOl0lyc4Owk8451L
	eqe7IwbIsD6SA27tjsxPUREIWWN/MhEQch3n8f4Dz8lOntD/ZNDU57tuYF6gGU2jzlE28/nt7Nz
	rttloH9trbyvXHTGcRJEr6nwXCY+vPd82aeV4VE5POvgoHuuQUk+jq7yXQo07Sb8JVxeXdljUIc
	HPS15nXZMw0qHoBwJRiQkS5AA=
X-Google-Smtp-Source: AGHT+IHBepnSh/nJMIs+AM56HkBo2+XztwsCngVj9gWh9ekQI9mRoHgowgr7zRoiZ6RUf6OT40Hilw==
X-Received: by 2002:a05:6a21:99aa:b0:2e5:655c:7f93 with SMTP id adf61e73a8af0-348cbeaae49mr13919906637.33.1762110260311;
        Sun, 02 Nov 2025 11:04:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b99801b0e6csm2864275a12.24.2025.11.02.11.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 11:04:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Nov 2025 11:04:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add ROG STRIX X870-F GAMING WIFI
Message-ID: <daa6640b-9044-4586-a981-13eea7fbcd3e@roeck-us.net>
References: <20251102114038.283396-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102114038.283396-1-eugene.shalygin@gmail.com>

On Sun, Nov 02, 2025 at 12:40:28PM +0100, Eugene Shalygin wrote:
> Add support for the ROG STRIX X870-F GAMING WIFI board.
> Testing done by the board owner [1].
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

