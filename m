Return-Path: <linux-kernel+bounces-859195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04396BECFCD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C9844E88A1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C8828314B;
	Sat, 18 Oct 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDKbV9bK"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C2155A25
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760791761; cv=none; b=RMq/YBoDDizmafKfAXWSKsnxrdXtxKazRBCNk/oh7sCU4zSCac7EnKGBpBliZ088qVHJLE2k1rQoCYuVMQfJyF8/zQIoheCaj7W1RAzwM9ZFC8xb01RuevO0VDQExLm1HQnqjkO6QODO302Q9RtDE5R0cDfoRGTo3Quk8m2Db3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760791761; c=relaxed/simple;
	bh=4MTBUHheRoqjhOd7BBqxKj4o02h2M7yKv1+pjK7zjNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsocve03ANnR8qQzmZFR8Xxvdp0V3CJ6fUKVXsvRCbD0/lTP/9kn1ROQDWIKAp8FAGYYMJpCMvAZzs8JTpg77dQvzg28Aw/tRKVjwBYAG4OWNyPAnMvtIw5B7bFMV4aYkp+fffW8UqYvMgMuryw/Tp+rvCVuULgiI4Wmn1fQSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDKbV9bK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-780fc3b181aso1696755b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760791759; x=1761396559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNAClAvOnKjWB7HSzhh0yIx7GLLOVFoEN9nJoFbnxAc=;
        b=IDKbV9bKO+f04b0GOzAeXWpCiGQBfkLUB8Hqb8eG3fFSVZev9NVYb7bHrYIYfajgzW
         RZjapFS3TVokfOPaaW7bVxMucyiyRpENAgVGFHdxjx53fM/H5dZ0JStAlvqIA5vWF9oD
         HDK4pohPAQ4SGSDUOcndlLvcopheovBSnteYuQl7+tuVDMZ5czlr/YHpze0yzeDTCykn
         lTxeTktgFtp/bNVKehYMCcmZPMHWfxPmPgwuQaCrwBePoOE1MzgXBpIRB1OVjY6Br8vg
         tzAw6I5Z7cXdqjOmUY7PBdUs55rVo+xGSmnYObz1f3r4DbYA6ICn9vf/lCNgUBeZBt0q
         gjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760791759; x=1761396559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNAClAvOnKjWB7HSzhh0yIx7GLLOVFoEN9nJoFbnxAc=;
        b=CJJdfrLbrYfvayG9kELSP8XdL40k4MqZQw7sCVEjjpuXN7zl3tFcd87LgXSLiLHuve
         ZXiLaWGCghH3OM1g5ultwGzlfJg1DqW7MBRjodof3XkxT+OfUWB4IrKPTsVQ6evhQBxJ
         4V/bs+F2OexYtxYe90v7Xey43RRU6VBZtnLJhDGhmDh6gte3QyYa38pJMP6hdRJF1vB1
         5jPDFqVm4J3uBJ72VmN01GRdsZNx9aDiiRdz6iEi2Nu7mkS9r2S+15jHlVxnBwQ0MF8V
         znKWTUyWj7MAn0ehY1lfptWRk/PXLmpVF+fTG0W/qhqDSfxgXC0PkXEFEAe5+AKBoceM
         zJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUABQmIGfptdZV3DEMlOI+T203mRGTRRoYM8nEWAmPtEUREWAx6TPr3wsYhuSKw0kKLVJRCPNQ8sNI9F2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHGe05EbWf9vpETetWLP+TssVays7M088lyRXRpapbC+rkxBdu
	uMbixews8PWPfMD3ONtD5wedxw7c+z1C8HYnqCd51uh6mHSAJ9xGpwSH
X-Gm-Gg: ASbGnctBW2ulXyvhZyGW+uGVBD+WbBIuhpfs6NZWYjrfEdVNWCGSjbv2XKIgwRKVJGP
	/BfhQnG5d+bax5Dsn5cSV+quRDIq7tYi/sp2iBQnQVdMjBMM//YRdyhLhMqmuZb4iZ7aFqNPZen
	YICyP/Q7XneI235ju2LIv4BQTjpCZeLpPKVd/ZrzSDaGjb8UFeRXmdp9pjlnkGzqC5tSdPXYNkH
	OXhsrGEYzA1FhbZDVOYWHkioXt0+qPQQuTJbL4xkLUmWs4L/nCbEIDGLWfaZ3/+0obbpPmYnwpF
	ce4VZmofhmYt8e1bE84LoDoM+ykziDkRH/eE32UkrY9ASabif8gPUyzqOo0qxPg6YzreLEFihXi
	w6g7wA7D9c3AvmoJgAvwqI7dG6j4N0N1vB1UAnYPpyJ7ZDGBzI8pO55T6evi6FvZ9s4iQ9+JM54
	A5j5k6APUKAGZFZDXfFIgDmZk=
X-Google-Smtp-Source: AGHT+IGwvhlN1brRCS1BniG2CAvahGot/00JMhfB9nXhMtLgvouUhBqkuQKg7h/T0YyFAsClGr+64A==
X-Received: by 2002:a17:902:f551:b0:290:dc5d:c0d0 with SMTP id d9443c01a7336-290dc5dc3d6mr85320885ad.49.1760791758880;
        Sat, 18 Oct 2025 05:49:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df5c142sm2564379a91.14.2025.10.18.05.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:49:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 18 Oct 2025 05:49:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ankan Biswas <spyjetfayed@gmail.com>
Cc: jdelvare@suse.com, corbet@lwn.net, skhan@linuxfoundation.org,
	khalid@kernel.org, david.hunter.linux@gmail.com,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 1/3] Fix broken maxim-ic.com links to analog.com
Message-ID: <4cf1dfdd-6df1-43e8-a396-eb705e46aae7@roeck-us.net>
References: <20251017105740.17646-1-spyjetfayed@gmail.com>
 <20251017154755.32105-1-spyjetfayed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017154755.32105-1-spyjetfayed@gmail.com>

On Fri, Oct 17, 2025 at 09:17:47PM +0530, Ankan Biswas wrote:
> In 2021, Maxim Integrated was acquired by Analog Devices.
> maxim-ic.com & maximintegrated.com links redirect to analog.com.
> 
> Broken redirects fixed to their proper analog.com links.
> Fixes warnings in 'make linkcheckdocs'.
> 
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>

Applied.

Thanks,
Guenter

