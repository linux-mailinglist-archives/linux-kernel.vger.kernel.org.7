Return-Path: <linux-kernel+bounces-808144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5825B4FACA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814ED4E5F29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22118334392;
	Tue,  9 Sep 2025 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu0DJgJV"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A626CE3C;
	Tue,  9 Sep 2025 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420823; cv=none; b=H28lRn5PiEJTzfEK2bVrk47o8pt+7Knc0kYey5KQeek4orwI7uFu2JvgQh6p8+JisSgkBVv0kuPw/XQuvZZxSlIYRZgTTnmw0e9blRmVo67d+o9gI+oQk6r5Abb7J/Y2Gh0x/8kTJQywlPVnTMLjcJyi6DzPBWnQIFDTnUszlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420823; c=relaxed/simple;
	bh=OG7PoYxUE4lOLIa4R+sGX20fiSlwAUNYF+/DK6tmg/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuSI0lHxL3swGFzpQfhmgiXiyPAaeeQ4CmUc8Eu0ZTyXbuJD+KXG1XDk5iC0rQb76GGUImekI7YGQoIZ/EeIzeLDo/8CmTUTPfnUtj1nNEnUHJtwpFG1p5l8GGa1KvmDPB8xqXcEr7RnunwbRqJhfVtfu7aYTkGusawEdC4b7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu0DJgJV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77238a3101fso3935295b3a.0;
        Tue, 09 Sep 2025 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757420821; x=1758025621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGcYMtjAxhfhBQPVOt0qnGb8j/1rplubCfRp0+8cv/4=;
        b=lu0DJgJVjoHl4H7KyY16ghfEBZ+j59bY9AY6wlVy+e5QXcpahlMIFogJeAfzAlMgdE
         UEeUE51F1dYZ54sZYHgu1hlHeASGXRI1aMQ/vhK/l0SnSHrd+snuW/39slkCw3UcA/U8
         bAqH4g+20KING/pfdBi4a8HBvXCf7ZXR+XrHC5iSEpnLVhmRhcHB1abu3RNKV40hoLSV
         YndWQaSnDunZT/uo/Dplr7ZHUUCWQvj77Hnlt+Qo6slxmYC3H9hO8IB2MIBYnwSONhak
         NymJvmJJiWBgDFn2G8tz5ItL0pvR46O0mDgapMpwkJJrOlnW9bLrSHXFm7VR8ME8mnuf
         e1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757420821; x=1758025621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGcYMtjAxhfhBQPVOt0qnGb8j/1rplubCfRp0+8cv/4=;
        b=nrF4yXYYtpuCbvzSwiGFtiWc9zpz/xZLSd+4PP+iXpMx5oW+Soldilg97gqhRuHMla
         Nd6iBFL6t5UUp8yANe13GPXWaZ2wQCjU+CawjmqrSjpvZORguuK7IsHZ/zIMJ7tL44N6
         Uu2k7UTTcuhovpl1V7eaEUH537Xi6Gte4zSBPvAIlLtMZtnCMEZqBSjRRmmawLcvcQBe
         lnYMob2YNtPulsmYtxkNEe+YmVj6LVpftpPfrGRzhQxyCoFlSDwuBTXXJYB9/KAwjq6v
         U0amUrRAxzgGsn4zmFpy43otYqf2lK25lQ41uF24xBkYktVXR5wzHEn52thoI2+h1WtK
         lGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4AnGel1h+YXdp+S7Rf3NazVrtXnUgOpucq8OW/kIbMDr8Jl1vjmYnGL2Ndzzakgr3brbhdQt5x3yaJg==@vger.kernel.org, AJvYcCVWLOq+LZkkifEJDJAPyecFHcxQsTP029O9r3sH+RxaIgF36v+ya2HN7Z1HQn6tFXeB3daCwbD0XrEAn96v@vger.kernel.org
X-Gm-Message-State: AOJu0YywP+KL+Myqc2HQAjmBpGLE6K1/0EJOUvUxZgcV0+IE+crtPxvg
	ytL5qpmLqCoT1jX7vTF19yelpSEZ9bcrIQLnsazswi08vJX5BpChsbIK
X-Gm-Gg: ASbGncvmlVuDpVlXFwdPhbfHavG6fB00sl+HkcFnFqtvXsbLfCNu0o0TQBdfui3jOnE
	nW9aPirzgFhCXltWzYtjds+Ev44xui9zY+bNHC/964fwKVYbsF+S+ebu7fUCrc7pJZZ0E3ld2dM
	DogNjeia+2bk0glyIWnYLVWSSdIXNj8uldI9bMNLfRC0tT9ONjItwZe29A8RJTAI+mf8BZK4vGf
	bllkGSAd63wzC5edxSqPPejJ/go83dzBnA8YM8DBttbtE8fbi87JfxesDOBhRFJADzuMfVmZyEB
	iAfj+XF+lZeCKsr4qKH5TaRdO2Y4RIIRzZpcSXQpmietghscU9OKRWSHos1fQwlmTl2SIahE7zo
	W3DZy5w1GnlscZrqhrSEegcrGmwE7zTKddnWAbmmZaJiCrQ==
X-Google-Smtp-Source: AGHT+IGdOEWHRluUGVAE5pQaYGBxiifSZcN/M3T8OYGbnfFbUzd4PqqXOj9r+4ihF2KvwpJKfxpVag==
X-Received: by 2002:a05:6a00:148b:b0:76e:885a:c33f with SMTP id d2e1a72fcca58-7742de65de2mr13307991b3a.29.1757420821256;
        Tue, 09 Sep 2025 05:27:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77465eecd8asm2026933b3a.0.2025.09.09.05.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:27:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 9 Sep 2025 05:26:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: sy7636a: add alias
Message-ID: <d8b671fd-1776-41b8-9eff-755165718310@roeck-us.net>
References: <20250909080249.30656-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909080249.30656-1-andreas@kemnade.info>

On Tue, Sep 09, 2025 at 10:02:49AM +0200, Andreas Kemnade wrote:
> Add module alias to have it autoloaded.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied.

Guenter

