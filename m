Return-Path: <linux-kernel+bounces-860971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8611BF17C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077793AA58C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D952FB615;
	Mon, 20 Oct 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWKzftpZ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1E313E37
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965999; cv=none; b=LsoQWd90afOJB8P17c6m6n42FRJbRO4KDmToIsYwl2XdInH/Fj6hA+5YoRZHER1gtYqBMsA0C5W46/Xypwnm0/Zf59uYv86UcHD0HDMfFp1cl1JU5rlqroUoVMgd8EQjnboDAJaLhVJWGLz+pvP2LryxymwXhmdRMmmKl3XQIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965999; c=relaxed/simple;
	bh=AfTWvMNKWRx5WxVQtvE/gOVCLgHWI/aXpAmpAir+6FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJ6ABFXhFnePSjRVhLMnEaeXHeFqO9+8VsOJFGrWHuDvvA8WTsEmajFXTNO+je7iUkI2ICMGn+vP4N+8TRYZDml3MAHVhptAOBwNHU8TQ5cNunSxvyy18Gty0E9oXU+nuUVc9aPvUJcsVyCskCMiCwrtsRW51dgx/eZUCnGuZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWKzftpZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so4571279a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760965996; x=1761570796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AfTWvMNKWRx5WxVQtvE/gOVCLgHWI/aXpAmpAir+6FA=;
        b=RWKzftpZCKwLRrACgMwerlwf4lY9GljdQw66d3KQsgTkv1InhCpQInhGxBfaw1n8JR
         4o1CJ7VFsoln+gwUE8JF1gVzzwR3GtuxGkumiQqc21ppksPCfPU1hwyph255WL3/2Pjr
         tIPHksEWPHwAJPksfrm/sUBjHeWlw7EHnUZ51CPk92jyHY1BQqoaDD7miymytz6bz8c8
         lW8vgudr+4Ny7VDqzHpMgoHXXUOSXZyy1rzTlT2+p6qIUJ3pTvGamzEqAM0bUpzROIzE
         ldIGKdESpqXxYRzhCDPw9Fps1ZlIu95g2du1RFMK/UWXVtIXsm8MQXU/yj9IFG3qP1GB
         TGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760965996; x=1761570796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfTWvMNKWRx5WxVQtvE/gOVCLgHWI/aXpAmpAir+6FA=;
        b=cIAASpKPaW+yvMOH+QslrZCNNB+DSQZspBmNCfp+OYgjvOkgswB1RKqrWvSDtgaYsN
         2RtYpXUp7eVJ+uOZ7ii6r2/RgJBvJkUBB+ZVEqSrDdIpAXcsPgKpMxMeav9+YNtqDpDS
         Gwc5JguSycrmhDLdCCmTHmVDhvOFUGCNJeccAJ5HwQLZqkRQ5+0hkGxWuZjUSt/FyfTd
         iWLPBOg/iT1r8o6Vj5dDSS2rwvk05AFaF/verJISUlA0stynpYQW7uFXr1MF8FDUkwWG
         Cz79NU6W0ugDEUTtDNG/U8oMccm9Fc5rxUhm6vKp29cssijFEGekSKHKKHCYWrQArzCV
         SdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpjZvDNrujgO7Yl8UhUtzY4YY01FBUzCPWS64lGNnKvm+zgMtJoRgWAHMLCD8eDvHVMJp4YCoRcyppN+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiCVxCkAi5sPlFvyxGRg0n5JU8bIP+l84JrLen9/T0xUUVhzAc
	192/A219rz7kROxEUT23xB4rK7L0xLW+gBtRLznNig997EK/SmweXdt4E9AKhP/U9fli4g5PXjS
	A1Ducl2IDO1Nn/WWDeiNgDY1PVplNXc8=
X-Gm-Gg: ASbGncuvoL3psxL6yEae1OHTiMenjmDFEM0RWgC/agZxCziUipScEnsWNuqO1lxLbvQ
	Yz75cIxiOTlFV9xHEsTQz3d7DQJu0KIRAnO3YhQIgV99SlKtwKWa0Xaj29bzBmAoYfyhaj635vh
	lPqv5PR7TyOqOkfZk5qVdzXAbvL7WTu7xaV11gEmRWhhmDJ1OJpER9LhYq4WzOxaAs4F/e3AlrR
	jyYlNhwJnudlrE78646cQvlaXYIRJAGr4pNlNJ5IeYlA0kv+qpQU8noEwNQ+D2ieM0QbQ==
X-Google-Smtp-Source: AGHT+IGkvCcslMuGWcKmmiYvm+IPM089px853MAXbhcNPLqtcQdtbpNvAfvMxwruriFAZmBTYFnqkPO1nTFcpLSsyT0=
X-Received: by 2002:a05:6402:13d3:b0:634:b4cb:c892 with SMTP id
 4fb4d7f45d1cf-63c1f6f5e21mr12850362a12.32.1760965995705; Mon, 20 Oct 2025
 06:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bec52694-c755-4d88-aa36-1d96f6d146e4@web.de>
In-Reply-To: <bec52694-c755-4d88-aa36-1d96f6d146e4@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 20 Oct 2025 18:42:59 +0530
X-Gm-Features: AS18NWDB1e_FyEckeUmSdlDJl4jkx28fYBY2kJO7NxW6z_MYSbVArRJYBBg5CjA
Message-ID: <CANAwSgS5ueALsrbV+Oc4x+S=A3Ucaji0WQaKCLoARii3gc355g@mail.gmail.com>
Subject: Re: [PATCH] i2c: designware: Omit a variable reassignment in dw_i2c_plat_probe()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
	Jan Dabros <jsd@semihalf.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, LKML <linux-kernel@vger.kernel.org>, 
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"

Hi Markus

On Mon, 20 Oct 2025 at 16:39, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 20 Oct 2025 12:56:39 +0200
> Subject: [PATCH] i2c: designware: Omit a variable reassignment in dw_i2c_plat_probe()
>
> An error code was assigned to a variable and checked accordingly.
> This value was passed to a dev_err_probe() call in an if branch.
> This function is documented in the way that the same value is returned.
> Thus delete a redundant variable reassignment.
>
> The source code was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand

