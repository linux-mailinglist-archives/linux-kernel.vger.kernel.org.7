Return-Path: <linux-kernel+bounces-809526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B959B50EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E6F1BC497F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A5C2F90DB;
	Wed, 10 Sep 2025 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp2RmvMg"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239A81798F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487799; cv=none; b=fqDAcdWt+x2oSI6MLhE5Jt8hTQ6vgQ+QW+Z6eNebQU+iZ8zOIejMPpLsYlb2EEQXadlt5eu6pShfbaWkDtb2YZw60e8CLdPK9x6QaTs+CItSiO0UEKwr6tOyHHwb49mOkk88XNFvY2pwFRrAaiL0p0DJc7FF+V1AZki5Y4PbFDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487799; c=relaxed/simple;
	bh=K3sb3O0WaaCu0/VJziTkMwe7dsY/QjdigziLXVPL3Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drmoRK5nrgkmSQeK5ebyjQKglJ5+BipQ6C2wYOKL+yHlX6OwvlLBS88NUeZ0ISro6oqeeOvsKlhr1exvFYjdHDizFAsYbncbXxyOjz7uauF126xXlNGUQ4SCnlV4VD/5VEwnLDAc4kpzDW6TD7QNVFeLenB9Una5Zt19unhkXME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp2RmvMg; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ffe6666f8dso16385705ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757487795; x=1758092595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3sb3O0WaaCu0/VJziTkMwe7dsY/QjdigziLXVPL3Iw=;
        b=cp2RmvMgkHABLTLRVMQQfH++7pmqweWf8E63dASlz+2KfB7Kh4DgZ00iFLQZolTerx
         O4mAYMCigJhUSKYlmFubG6zAMDPeGkKHwR1ypQVBUSFCwidcd0LpAjSa0ef3BnmY9Xzn
         9z4yT8pCYx18ZheBSdl3WOKkx2BGsNleJu+JrZgdPZvJAclGVoswirkfaJdpDRwErMET
         yA1VVBsoHvtH6hJaZR4PokibhfXO1CavBnHHeS5ICALhylbeYmXbdZESFiCxbjhMUdv/
         hpmegQ4FRPwmUpShCDFzTOSOYIiQ0GpXLIP5U8APqLuja7CH/t9XEIV960s+890if/bf
         6ZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757487795; x=1758092595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3sb3O0WaaCu0/VJziTkMwe7dsY/QjdigziLXVPL3Iw=;
        b=LKeQi3iYu49BCXL9v82HhE3AxTe/X43Fwdz5WopOm5gA+X1YaI218IVzyJGWyKkpcz
         GwXbiOhLppmlCwIB3ng/TKCtYoW8FsftAeIsUB5zuv+5D779GGIYAV1F17myYTlpFmX1
         jHLHwOC6pAaGfUZTILu9pW5ADfsJNlHdkDL677q7e3+qo71wmA9XUABxaDuOUsv1fLG5
         euqhznORU21dtI2NXN7yRG87XVg7Y3XdnXdmUgk5W7tEoOJqIyaQn0bvXSko+IVOEqAx
         bLp8Z5CAU6rAePcQ0KY4cFejdzlk7msujBl4BhJN9292fiABYoRsVPAEWt+v6mN9H38v
         Wz3w==
X-Forwarded-Encrypted: i=1; AJvYcCVGPKLzq4v2pgOqh5ihqoBgCXerx06/0pz0JF5g811M+anPzP2yDqv9pb4pT+ogXJasvvUePp/E8yJhaCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTa2QYtzermuL2RJy7czlnUv4yiQgwFNGKhdAE0AWhQ3jB6Bkp
	SHQD5K2k7Sr5n8/h7bzDc3NNxCf64H1vO9Z9OoivG48bxKpkFe2ePc5POC8vXRSVaQ2D+XKxhgg
	tIPtLiBIsUr7E8/9dpeKdqIi2Yen7U+g=
X-Gm-Gg: ASbGncv/WzIToWSYOl+PBvlHrQm3Rxfqy77lw47IMoNODYdGH9DCYwlzZd8wYhzmyA0
	JH4ziwyQXnym335ZHccLdWXUS+SFls05Niujluw/SdZ4hSZggb2BFLy4zVz+3EnASNr3bgTY9gR
	jjNxsCt06Yl4n6XdFJQFys6iDDGP981evUP91GtIB54/4pNKFw/sEIh3huO3/GE/qsT2qP0q3RJ
	eXH5sa8XUfyEh3t
X-Google-Smtp-Source: AGHT+IFRXCqGqREn+YxT6ZRBQQ+/gQ+Gwx5iX5XmgokBagKB2BNEC9oKGjvvsbIx8yoWxpnf5nOBNea7lamS0o/4C6A=
X-Received: by 2002:a92:c26a:0:b0:40e:adf8:ca2a with SMTP id
 e9e14a558f8ab-40eadf8cc5bmr102324035ab.6.1757487790409; Wed, 10 Sep 2025
 00:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908070124.2647038-1-rk0006818@gmail.com> <87tt1djtot.fsf@bootlin.com>
 <93578759.11447.1757322260340.JavaMail.zimbra@nod.at> <mafs08qinn92v.fsf@kernel.org>
 <CAKY2RybqkE74EADTPnCUHAXpJLJmM9skPXQ6S3UOq8TK_y9EQA@mail.gmail.com> <589829523.18235.1757447430401.JavaMail.zimbra@nod.at>
In-Reply-To: <589829523.18235.1757447430401.JavaMail.zimbra@nod.at>
From: Rahul Kumar <rk0006818@gmail.com>
Date: Wed, 10 Sep 2025 12:32:59 +0530
X-Gm-Features: Ac12FXwBsZJOjWnbMMWv1I2jpV-70BlTyF34pse8dnrTr5YRb8hM2Y46Rkfg8n8
Message-ID: <CAKY2Ryb6CLLYBWH6pipDGV5SHv8GiZJrPb-KOWU29g=yYkzUgQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: sm_ftl: replace strncpy with memcpy
To: Richard Weinberger <richard@nod.at>
Cc: pratyush <pratyush@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-kernel-mentees <linux-kernel-mentees@lists.linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

I sincerely appreciate your encouraging words. They motivate me to
continue improving and making better contributions.

Best regards,
Rahul Kumar


On Wed, Sep 10, 2025 at 1:20=E2=80=AFAM Richard Weinberger <richard@nod.at>=
 wrote:
>
> Rahul,
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Rahul Kumar" <rk0006818@gmail.com>
> > Thanks a lot for the detailed feedback on my patch. I understand now
> > that this change does not add much value, and I=E2=80=99ll keep your po=
ints in
> > mind for future contributions. I really appreciate the guidance.
>
> I hope my comment wasn't too demotivating.
> You are *very* welcome to improve the code.
> One of the major problems in open-source projects is that
> we're short on review power. That's why sometimes maintainers (including =
me)
> react grumpily when code is changed just for the sake of change.
>
> Thanks,
> //richard

