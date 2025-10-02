Return-Path: <linux-kernel+bounces-840824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB1ABB580E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3313719E7B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F204627E048;
	Thu,  2 Oct 2025 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOujQqn6"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106801E4AB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441251; cv=none; b=YyrszsVqE0j47hPp6IVSeroRMS2pIpKlurlum2uYiK929ocFcimF43BFKC+qZBDiHC4gWz0myLlDXmOcl26LrUHmH8WUnXImiJSGCibWBrwC6D153J23M/jopKQS0J8zhm8yOqSFUtvwXIZKrGJCrWxE0gaXfIMZzpT73oftkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441251; c=relaxed/simple;
	bh=4br5TXp20Sa42/FcnLphmQ5GaWo3dSD/pk6MBmPScJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBehdO5dI4AEAg803scgBxsU8MfkjZH34bag4gqF+wJedBgOrvKkMZPQ6ELviOtsU/H2wrJ0ozXN52HZiR+dksYEzV6crkFXc9HkiSCNg8+0zY20Eon3e97rNFSovqivh9uIv8SRAmf+ZLvUIyl1UfMPrvr0rjtggcUEa89UkKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOujQqn6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso1439078a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759441249; x=1760046049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+g7WCpxhGw/kfoUiPXF0Q0M8PAzBxjz/5AXzmRXGxrc=;
        b=MOujQqn6snK0uKJg3td6LBFlTxmHHa0gKfAcaPvkUnqvbPzCG2IqkZSDxPa597OLJi
         jbkqhQtaHw11z9q9CwF+T2FZq5l6w07lFgEjixEnzWCu+65BVw5aF4T74bnpz+mM9DSl
         ehgFAI8Iy3NB+DMgRVhlo27AE6XI9Y5lwnxScCCuBBDHxAUsWomNYjNZLoCdCuO/WdYG
         XaCzd1qtDIBZrGm08drqE97vIIvvPlNzgi2vF8QNR09CUgqfZeL0NxXGk44/nNjjRdpy
         rA4zWVBbULJuJt6kIuQifjDYhhalSyGCmno8TJfh8N3udC25dKWRf5KH7nGyK1MqxJ0d
         rjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759441249; x=1760046049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+g7WCpxhGw/kfoUiPXF0Q0M8PAzBxjz/5AXzmRXGxrc=;
        b=l84C+010ottFqi9W9afGND3+T1so0UrFB5ph9iUtaSJlP8MT8e309lbyuradg2ir3c
         76TJzrC1JznkNTGzKdTCHG33SoU4r7r9xMTnAOaMDYAtvwihOmp+MGYh3Dn8lT9UJmMA
         EeCoptB9cxFT4y36luhuXCmuA9+Xru6bc+YkPP2AjLeXbLJUPb0Svr2klH7C40jCYP19
         ASK9qh4kwbL4PHvdeovYfSXWmKgwPsCtSe9ohBl2rhwhe3D1ZGE+xII68XbU//DRMXeZ
         yCTjFhIc0MOsAtuVn4l1t1sxM5Kv4WQk2G7+dnVMGYwDvCEjz6U4XDepxYVP89rzYFau
         ZJ1g==
X-Forwarded-Encrypted: i=1; AJvYcCWNgTNpSEbLqJh5pkx8NmmirR0t4vVoAvfTPLJOauY7yBYHjofNq5zbOG5TDxAMlWkSXYiW9AOFgLe6Pnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLH6r7KzdG7vwzA6794y0E15uHWD7uKOybf41l5BLO/rpgWohC
	mOsvEb27GVVYArSLdWESmsYu9nPBjbw998lba735jtwZnPDYldeDo4zL
X-Gm-Gg: ASbGncvXwZjevZ9bJ8mmLBgahksyjsQ7zSGCNFzZ/wdMXw0efGQl8uLFbbHpNna3Hlz
	ooQDhW+sdzzp7REiaHJkfrpG+aijVtq761owQj1d/YdM5tzgJ4zMulB/fYG3NkTQlwwlKe0HrR0
	bEpbsn5Du+iWZ5h4jVY6cs/ILhaOwxUeEA2Ymg7TN4aD7yi2YgwZa8fygmm36wxGJvSKG02Xcln
	yc7iPI6QX+WXIKRosrsPlMyn4R1aG/uIlECitYrTNo9izL3Pu1kOuuxA7biWpPlGzV0YOnj8yAJ
	hyzrhCnIsYzvaHJEO1UuuJc8Ebibb3cakB2gFdNRu8lJWF0eskEoaznJKZGpGlRPNXNumtPbRlj
	aWVtHdaKXjD9YkqQU8M9BeLOHWktJCf0vpjIdt0x+DsvSLiXhkbUdUsJ2B1g=
X-Google-Smtp-Source: AGHT+IEZKtfG4lWFJ+VDJNIZB0rz102xqLGloS2pPVhFCwbbWN3EfpP8unSWU8sfUUl8oUSB1hU8Rg==
X-Received: by 2002:a17:902:ce0a:b0:28b:4ca5:d522 with SMTP id d9443c01a7336-28e9a65656bmr8167645ad.39.1759441249357;
        Thu, 02 Oct 2025 14:40:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d11191bsm30420125ad.11.2025.10.02.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:40:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 14:40:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (pmbus/max34440): Update adpm12160 coeff due
 to latest FW
Message-ID: <00cdf890-9f7a-4f98-b170-a50fa8d5ff37@roeck-us.net>
References: <20251001-hwmon-next-v1-0-f8ca6a648203@analog.com>
 <20251001-hwmon-next-v1-1-f8ca6a648203@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-hwmon-next-v1-1-f8ca6a648203@analog.com>

On Wed, Oct 01, 2025 at 08:37:07AM +0800, Alexis Czezar Torreno wrote:
> adpm12160 is a dc-dc power module. The firmware was updated and the
> coeeficients in the pmbus_driver_info needs to be updated. Since the
> part has not yet released with older FW, this permanent change to
> reflect the latest should be ok.
> 
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

Applied.

Thanks,
Guenter

