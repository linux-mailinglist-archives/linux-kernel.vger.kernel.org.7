Return-Path: <linux-kernel+bounces-733730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73015B0784F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EDCA419C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B587F262FC8;
	Wed, 16 Jul 2025 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc6m4x4F"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39029220F2D;
	Wed, 16 Jul 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676814; cv=none; b=QsnKsE4VIINJkf1ljqdDd1UPFLwLk1mQdTgTur/TsRmlmA1Fn9q7FFhy06taT1VFKR2+7JgJUPq5yakYFJRjLOStEBrcWhcEUWMM7hYAPtEzfk+LoAKK4q77aHyD+QZEfjMAar0AGXXFsm0LNFnX7OiSXORKLPL4eGNKKGyVI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676814; c=relaxed/simple;
	bh=kGOHToV1J7kqTOy5nhKX9N6MPzipS3aGSHKwSahMaZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6ISP92SNqN8ju88Jz0tiG9rudW9+nj/7vXQgNPDKB4WNxRtvsJIxnqPjchd4QDae90rHe6NdMLbOGssEIa7rqADM3LnM9sQ2sAkKhACbJsxXEtHrV31WzMYLK+hD7NNHbHGMLusIn1vpAQ3xQRc1Ke9DpiIiytemPTxsQac2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc6m4x4F; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23602481460so63940475ad.0;
        Wed, 16 Jul 2025 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752676811; x=1753281611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRuI93NfBbD4JMygr13VWxhIviExAdSOd88w8cYV4VQ=;
        b=Mc6m4x4FHg9txu6e5HbtXULFG8nq8ZZsaT5oLv7DeT92uKchtH29Jyzhv696rcgoiz
         6I5x+z1LdAklN9znh++nBGD+jamaOzRXmtlkSdvBzcxSdRWsiro8dsMC6Sfa6Ys2ayBT
         axBkc8vJFFKaKd+rLiF6UJlkVfn3kF523a1PK+KzRmyj75RADJa1NGjFrLc21X/zH9NT
         2AQJF77tAZS7ov1+HW8OtrEccXa18C1KUg1ygmu6U0OMSuJSkdIR1gZVLw8/GbATSnSe
         zhTdOByG0DW7sbmXcEdNPFO4lFJa0Fk6WvMVRTIr7Fe67B4dTPl666PC6kxZ+X4K6uAU
         tDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676811; x=1753281611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRuI93NfBbD4JMygr13VWxhIviExAdSOd88w8cYV4VQ=;
        b=jiYcsxtHON4zHYSxgFp+abzvVcTZLa/92u7eU6Ozp68o5iXAH8hz6QK9Jmh1I23n/6
         2GKu2C8PbRjE6CuHAbADqbdwCxLQzK/fdkPDxvx1fHCLXBH4QYykcQSscLpWJYbz7Y7S
         T3Go2ar5DwCfaARlPyBsHreRueewkz4oVv/Gxor+0Sl9LUtK4KihoQIgriht2X0wO+y5
         BV1Bd0Jg7K06m5eNXGk31R7v8v4ob6345/iXen+KWSMJaXsjQMI0e/t1EPO7sR5R//Hz
         mOC1kFYLAe3uJeC4rS/lsbuqO7JVR10ADarYh54T4hLUXtyE7lWw84QwID6KTHgfxmYM
         EkmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgAvqDI3eGMajLyv3Z/chFVdvfMgAaJsBMxZvPbT8vIzitqL5Q6XretCFagTtgASwWKwazLYav3cJHwkMGeRg=@vger.kernel.org, AJvYcCVDfV3mL5dURNPoq7eWk/kDUJwExv06fus0FmwXj16WA1AYl7PnPAGSAg/apEaOX5K8wFQ0shEFGWca/ds=@vger.kernel.org, AJvYcCWB56kRSBLfTNsrXW/1kW2hYXCKBKvkw7CfpVsswCGNC1mEXguTPvKBOCMlZSPwpUbdQUjzRAGyATIw+N7G@vger.kernel.org
X-Gm-Message-State: AOJu0YyGHfiu9YFJ8uvNlmi1Wv5HhEFZ2RHKtiyKM/TuUEG3Cil2NBca
	UaA1WdHgrM0CYwUXG2lOdrePtp2MtjMP71777E8T22P8ubwcjVa+KuiXKQag7A==
X-Gm-Gg: ASbGncumvdSwFH7/gqUjZ64J/MOTKsDDrrPl2tH0S+jeq+YB23VLdtRP+dsOJ+bE5r5
	6JnirAMZd/mHjw3EzvHHhZcR8wIivtaCYX/ciSSdCUil/LAB0jb7F1nHU1Ep+5lO5VDGwH8pt0U
	54GiFLbc0IzvKqQAWro9TSRU4R3YamY7Rs933au/wqKJXJdd+1c/PQlcsjCBKEM0c0m4WDc8FqF
	2buQ+oa9N7dWJksEi1AsXqRudtZqLpWICEOVbjT8LBLDRwICP0OOYP9KshR+cHNzRRRicZApsOz
	4X2wrZL9li8NgV/C6YeMwZDENfXLDkIo4fwpm3TGJ0Ql9ADmIh9Mh66eVwb8/eoY7LWLt1fuoLz
	jkTEuucQ1h7sK7qSZ6jdMB3qKKrU0fYFRKVo=
X-Google-Smtp-Source: AGHT+IHf1DvUVwTjYng73AEZoysczEQhV7icrvRQHXOxfIiXakEuliCr0Pejt20CVRynR8ZyGms4FQ==
X-Received: by 2002:a17:902:cf11:b0:234:ba37:87ae with SMTP id d9443c01a7336-23e24f3648dmr39945445ad.4.1752676811250;
        Wed, 16 Jul 2025 07:40:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4333c90sm126851345ad.157.2025.07.16.07.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:40:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 07:40:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hwmon: w83627ehf: make the read-only arrays 'bit'
 static const
Message-ID: <a9e8e4f0-f933-43a4-9d2a-a56e09083779@roeck-us.net>
References: <20250714155505.1234012-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714155505.1234012-1-colin.i.king@gmail.com>

On Mon, Jul 14, 2025 at 04:55:05PM +0100, Colin Ian King wrote:
> Don't populate the read-only arrays 'bit' on the stack at run time,
> instead make them static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied.

Guenter

