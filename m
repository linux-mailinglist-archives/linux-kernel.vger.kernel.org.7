Return-Path: <linux-kernel+bounces-883299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD1C2CFEB
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B77465B48
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7D314B95;
	Mon,  3 Nov 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3X9EsfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB263148C8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185762; cv=none; b=XvrXvNmvGATXa8j9lVp+y8bHMUQ/zvEfHnXsbft6Wp890MATJMUg+BHNMeLrfL1vVw9isjeXkVsYCwv6ge1JXQknAil8eaQTRNodb+tbRpFzYeJ9DWcVN8W9KFf2LSnBMkQ28u2sdiISgfPNeDgVnO8tGX7nvZ+w5vYvcMGB+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185762; c=relaxed/simple;
	bh=sV53YyVWcrRT+m6X34+YxDxrAbFL6QFjy7bBsEShcEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8z12x329Gyepm2gfeHnMuTSAn/ZeHUKrQlw4INSJFrAiESgklxoLq7k5ENgkJxeKLuEmfOhsX3s+6FqHQ/KQNDIZyq+9Rb8s0ZnOfJeiQZhZqr9fuZrp088NAyltnNzYVLJV/u8aQx8+eQZLt97Gs0nx2pKP2kM5Q/ClcrW+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3X9EsfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E666FC113D0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762185761;
	bh=sV53YyVWcrRT+m6X34+YxDxrAbFL6QFjy7bBsEShcEo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T3X9EsfSx0HYATlz8gEUMmbJU7FR4RQDk0avZO0EwHWDdd4eqM+Nq3v0LpcS1KYqS
	 cuSUth6+qN2ixUikjgt1EjH4VA+U2BHZKV6lAtw8m16YQUii127o8qVyqOsRjbiXpc
	 JiMStHBpsMyxNKsKP3ghW1ZbYBKz/qeXOIu+ghr2yBDKL22CXIXna85AsFbiq6oCW6
	 xIfoEjHZtLI11+gK6DoeqGP3favuC8ZtziR2NC7tlYd/Bc6FJh6GpNL1mVTe5o0Hxd
	 jA/Incz0E1IK165vXBRoY4oSSZQ2IMoRCVwYuulk2ZL9wmj9mSBTFYmSAb+MgB5yE2
	 bEy9U0TEpdugA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c53215c3c8so5214448a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:02:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnnW6QhnxJrmU+R7NbHDiksXmJbpgAnd9ENukLa/559AABV49Y5NrVlQ6+Rs43H2DmEPoNB4rYlApK7Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4fNPtNwvvf1SRU303ce0HruW5Cy19TcYgGJpuLsXQUR1GGh+
	ElL1gXNlMzwMzKG66dINajUYBnn0U5V/q/ExzSJVm7PmEM6O+1ujsIIHAwYLHLCFJNOHp5HTTpR
	BIJw5hd5lKGPkXk9woS7f8HHGZLVFKHk=
X-Google-Smtp-Source: AGHT+IG930y9apAOPt/XrUBvlxGLmexeDZbsEg8mrGDcQqgS9OsYketEofol/FuF0vXE3Pttu1s8pCWIEz9L/xGOaag=
X-Received: by 2002:a05:6830:6a99:b0:7ba:8107:d559 with SMTP id
 46e09a7af769-7c696799d22mr6133427a34.26.1762185761225; Mon, 03 Nov 2025
 08:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027192628.130998-1-jonas.gorski@gmail.com> <aQCK56FcZSCZdmgE@smile.fi.intel.com>
In-Reply-To: <aQCK56FcZSCZdmgE@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 17:02:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i7CZDhMbx4JKmQprwWCnVG4bAEYpH-mddxJ6tJdb8wTw@mail.gmail.com>
X-Gm-Features: AWmQ_bmbNUXYIWq2xTKrp4Rx-wtHwD0Gf37ZD3xa5PGDwzmma4kAB2NmsI8fp0o
Message-ID: <CAJZ5v0i7CZDhMbx4JKmQprwWCnVG4bAEYpH-mddxJ6tJdb8wTw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ACPI: i2c-muxes: fix I2C device references
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:20=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 27, 2025 at 08:26:28PM +0100, Jonas Gorski wrote:
> > When the device references were changed from relative to absolute in
> > commit e65cb011349e ("Documentation: ACPI: Fix parent device
> > references"), the MUX0 device was omitted from the paths.
> >
> > So add it to fix the references.
>
> > Fixes: e65cb011349e ("Documentation: ACPI: Fix parent device references=
")
>
> Closes: https://lore.kernel.org/all/48d0fb45-096c-4caa-b51c-753c2f17f018@=
gmail.com/
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied as 6.18-rc material, thanks!

