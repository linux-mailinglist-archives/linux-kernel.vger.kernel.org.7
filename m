Return-Path: <linux-kernel+bounces-830700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA88AB9A53B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9E116C492
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98763019AC;
	Wed, 24 Sep 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY8XANff"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADB3BB5A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725198; cv=none; b=ljaAsIFmypNDPdRKbw3Y74nlHoRGF/Rvh+cg+gMYvdzqCbi+9wfOePVW52lI5Co2LdNZsSMC0GFbLnYmcGU9zLkKiiwv8v/BjeMnXp0E24kNHZWBNGYtnhTnsHBGsIZn3I+ULsc8pnciPILGt/NRD6wXsco8S95A0AXgLe32lvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725198; c=relaxed/simple;
	bh=/b6rzqpITIsdOkOWf3TX2gnpE429NTbrry3tVkD53A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuWd1Tyt9nLIE71fqg8Jlcn/NpNrhedCVGkN+2MG8VhchWafIenxeecKpm3OLFw3IWRH0zHPEm/nO07XP5ZBwfqf23pcYvnn9LIhiHje5FwIbRpnIkOO3dAyclIAcBaGCvkSHK9ApK95Eh1sZkEfyG6/uNHGAZOBuqPy/fTRVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY8XANff; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2698384978dso58493045ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725196; x=1759329996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9ouh23wKH8Hov1aS4+sRdnO60nkd+0PEUnBljYhGHw=;
        b=MY8XANffHXUemkf4q3A8Uz7joHyzO920Nxpf1jIadlT67WOxpBkc/Fg8kfsMt0WwtS
         FkzQbXdodiDdFqQLvoyBDgbCyPTANQmi5kceyujKTn2BjMduuld6GzGVaxZMSZ9ZgH4M
         lBp+/dwC1hVd1CB4r1craSQMSIHR63uer6Eo/FcdF7hV/44AaaINF9sXP7VccLzfgt1I
         e6FmtB+UTtXJ8qg9KYDH0MbamT3gGrx//Hx2Jk1Ze7VYHwv8ZplvwlPe6sHunyzoEKwG
         0lVmZa2fDnCdE2KUqIrbzfzurm4pjYmtNwUro1nwY4LRgWSuvYCDm9pJa1Z9eXBPyvkn
         9OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725196; x=1759329996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9ouh23wKH8Hov1aS4+sRdnO60nkd+0PEUnBljYhGHw=;
        b=ViEXuAXcwv0alnmop/lu7vt7UZILStGJ0lJ4G+VbRvaMwLmlLL/l2LIrmXzYZME5WO
         GMZxjpnZB+2WL0HFwQF/REbC1CPcLuyvCvhfyQOa6oZVr6uxADRwnYcsKzKOzK+4qjSo
         odBI77Wg1WsSWZhsRW7RP2m6DfineGV7OH2fNnXyvWpg4J1/aleFkG9yA0guoF00QlLJ
         Zi6wces/jOq31AG+Qvdcfz8+Hn+HFiobKHOKeqX1xbDe2lo/LtGcExP+ZlHTfie8wW/b
         jC2Ev8WNOt5WPqhkDFWRut9zaSdntbDjhZjCZalzoCRWEnEwv4vGAT4H4UpfVmWge8nO
         fF7A==
X-Forwarded-Encrypted: i=1; AJvYcCU1fXwKFxVEPS4Fr2hYVJydEv0AgeftZ2H4l24xBsQd7sIg/ZNgcwB8s27o51HVVztWuLTqxWiiVa7VjUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEaaL/9UNgufEcAFCPtS4xkzMQKiJv5yl03sKEeRSWLZFCjtCU
	n76pt/X4ELABsPfhjxyrhdWORqleowmr7WEGyhIazhMLvt32Hfl46R8yzYpP+gQq
X-Gm-Gg: ASbGncsUMxHXj1s27BYr/MtDyUZr26etYBkNzcnRwUrd3ucJBPveXa2eav01apJ1YO7
	/ynLD4XjdvxsUnku/BNHCCXLbejKDm+g/NtQ+ea6ygBR0nSyXZGIqwfchj4ximvELLb14TdtxTU
	ElvYJ2HUddUgYYKktud/jp3xIUoqRc+qrw1B0JzsxNrQUHrDF4NElyZ2xgUQt4KOA2AFjmqo35t
	tvoclTBTMqrJ/lBLxwR7cbsm9IrEpFXxYRi9LCQ33E9DNLPv07VemuwM6/zOLWiOWdhRZm95vw1
	mRdGQRnF5lJ8lG51H25rSMwLG5YK4iOeUtpzCcBDqXfRPtUv3wQVH6yMNqblkkWrtLp5Zm3qK0l
	bLi+fwsK5QRu5VF8LB2Npoj/O/lUOgjkvVpc=
X-Google-Smtp-Source: AGHT+IHqSoeyuuO2C2WGsp9Xf1TZsjA6w4VP4HE3ZfihkrSmGZv0rK5DAquxViezbQIaAuFaSLgifA==
X-Received: by 2002:a17:902:e951:b0:25c:76f1:b024 with SMTP id d9443c01a7336-27cc24e015cmr72459785ad.25.1758725196096;
        Wed, 24 Sep 2025 07:46:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bdd3a0dsm2660014a91.24.2025.09.24.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:46:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:46:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] hwmon: (dell-smm) Remove Dell Precision 490 custom
 config data
Message-ID: <a9a60505-97ef-4f50-9da9-6caccbccbf66@roeck-us.net>
References: <20250917181036.10972-1-W_Armin@gmx.de>
 <20250917181036.10972-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917181036.10972-2-W_Armin@gmx.de>

On Wed, Sep 17, 2025 at 08:10:33PM +0200, Armin Wolf wrote:
> It turns out the second fan on the Dell Precision 490 does not
> really support I8K_FAN_TURBO. Setting the fan state to 3 enables
> automatic fan control, just like on the other two fans.
> The reason why this was misinterpreted as turbo mode was that
> the second fan normally spins faster in automatic mode than
> in the previous fan states. Yet when in state 3, the fan speed
> reacts to heat exposure, exposing the automatic mode setting.
> 
> Link: https://github.com/lm-sensors/lm-sensors/pull/383
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.
Guenter

