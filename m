Return-Path: <linux-kernel+bounces-849119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2407FBCF3E4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B74F434BA19
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC5526056A;
	Sat, 11 Oct 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNbkR+2+"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F02217704
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760179968; cv=none; b=Mtzka8KB/GKecRNlYOZe5+pHjbNedUGHkST6YHTHaNPrmTLh3b4gdvXacXW2S/WQUUUQAe2DJuoj+nXbgcFi9tSAfFAgsv/tN9pbkwM06gvazpETCUFrQMhxP7DHjYzjQaqY9DMGymyi82Q/McawRAwPJONQXpKoYhLyJQDz8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760179968; c=relaxed/simple;
	bh=8OWEI2Ve7zxoRahlmtY7dTeIvWnJ28oqpstjc7JIgvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQGyd9vgLk7oLl7cl76ekstCa8lHdV7v3LREPGRWWt81542VHk8S4iQ59CO/W073u0MtZWry15+PIt6VkzxVArkspDUFWDCagdxL8D3ml7aVYK5oJyOJD8fZSHlR4qz7jvIwoAKClGOLY3f8JPUhC2DDnSOmtOevi8LKWjTgU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNbkR+2+; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso4105846a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760179961; x=1760784761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8OWEI2Ve7zxoRahlmtY7dTeIvWnJ28oqpstjc7JIgvI=;
        b=LNbkR+2+EOwh+dWGVtLKonqwwWU35Q1VNDtkY8THOFaW2Cb8OiSrqaaVhXQmIAgNoo
         GlWyk5qwq2VM7tjWJwWNuotmIAkFUfwN4YKIbVJTiQQUgtHIVIXXIQWpuur4n+LSymjg
         LZ+bg3fZxKUyIt9EcvByg9d1PlKLYQ2+X54woo5idX6zxGO8MnHC108n2rRbaomzVcBr
         IyLhHM7zutKcAmlZYldGah6Vj6UojasFV8/ji+myUIyyENQ+z501lfsh5FS474usuEbD
         Fh+bSwMtvmNlkcR9R/VtvJPYHKUHh0iR8Xu3H0j9l586rZ/zIJ4TJn/mlXySHbdJhTKX
         1GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760179961; x=1760784761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OWEI2Ve7zxoRahlmtY7dTeIvWnJ28oqpstjc7JIgvI=;
        b=mntp6QaoeWdw9i0LWw2joGBpgkNEr6n+JagDyTlU4n2ET++arqXNESinrsAMCYRam0
         UX586b4hA2Ccgnf+I8mcC/MUrjq4+sASEqMpnitcBYnJL5TuTqwcks0eu+N4WVNPB3gJ
         rSBGfJM90CJWaxgBfcSrfu23fv8gjUYx/qvhyLSD6SFoivOdd1rCSwkAPViTIYhmzOSh
         yC0SB01b1sPSp/yKmZMzYqQcAa4L1BdUwKx80sPdB9DNdzNvmIJDXdf0NPIq45g/AEZJ
         JT8rRz+l3Yq832FIo5elpgHhvI+CbJVSzFlo5yEoE+o2pgpPzzNiovB9qeDo7CXke7YJ
         3Crw==
X-Forwarded-Encrypted: i=1; AJvYcCVj9myp9cjT4sIRJuJyspRH7afAwn2dqh1qkEIF/ZRa0EmHVCAZKjmn7H8d47zmPkID/+buMKmhLybdDMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE4BTZxKxVBoLySux6OT4FXp4Br/j+FVY6ykTIHbK0npkrYBlD
	ZcH99aG3BQlzcENoEkIIPFCgTQOq8IhGOfVfalfxYG0Z1REqXcItaK/8BHnuu/KwDdMUgTeYuTe
	cSS0oye+eYArBTdXYkX5go4o8jEAIK08=
X-Gm-Gg: ASbGncujBG8so749u9UGv7nOp621ONUSdgg1TyaZe/KaoR5o+ljUm+4om1igMHOWab1
	brq9GiRyqrQrjOujtbgqgLW47tHuJ7QJnm7W75nLoR359g5vIYjy4oXht5c5mSjaqjdrNANy5zL
	Nx5noP5hqc6t/TX35SbcFKsoEun+jbWKztkA/y0r7O7JxuZgFu+TI3mh3FBJM7ga3eGzGTUycbn
	i2AuVmDVXLJG1TZwXqfYdHUe56F70hbykaqT0lWqaUAHig=
X-Google-Smtp-Source: AGHT+IF6QH0ZvGGeu7syJtGwnYam98YA7aQ4YBC4SL91FthZsg1FL7JABmIcldVJaVFWBD3dXjjVorqgK2JB9+CSoXA=
X-Received: by 2002:a17:906:6a1f:b0:b41:660:13b8 with SMTP id
 a640c23a62f3a-b50aba9ebf7mr1660189466b.31.1760179960946; Sat, 11 Oct 2025
 03:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
 <20251008031737.7321-2-raskar.shree97@gmail.com> <9970e8f6-8b8c-4d9d-97ce-f89b948d6c97@kernel.org>
In-Reply-To: <9970e8f6-8b8c-4d9d-97ce-f89b948d6c97@kernel.org>
From: Shrikant <raskar.shree97@gmail.com>
Date: Sat, 11 Oct 2025 16:22:29 +0530
X-Gm-Features: AS18NWCeqmbWUT9hRBS5hR7tp38w-hhCaezVQ74ixvOjKVU1p9A72eXYN3wOTVU
Message-ID: <CAHc1_P7PDOMqrBxvXx-fO3GkncapOsqkxVs9HyZdwReCQFn9jw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> >
> > Changes since v1:
> > Add unit suffix.
> > Drop redundant description.
> >
> > Link to v1:
> > https://lore.kernel.org/all/20251004015623.7019-2-raskar.shree97@gmail.com/
>
> This does not belong to commit msg but to changelog under ---.
>
> See submitting patches.
>
> You need to also start testing your patches BEFORE you send them.
>
Hello Krzysztof ,
Thanks for reviewing the patch and sharing your feedback.
I have removed the changelog from the commit message and added under ---.
I will test and will share the updated version of the patch shortly.

Thanks for your guidance.
Regards,
Shrikant

