Return-Path: <linux-kernel+bounces-846925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFEEBC971B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E013AE6D3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD7F2EA16C;
	Thu,  9 Oct 2025 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k27jODSf"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A72E6CC7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019027; cv=none; b=qSz87oRUvlE7IxKnpsb/dBrsI4nCiHJf0DlrBnoPzz1HtpdGa1ckOJ3NtyFqvzspjBRVeuKs+/hP8P5wtia4uQPfTrDLHwbjZdPR33gn1oL0b/t8kW+NG7F8uKze/KCPFVfLEnnAGKtM+2Gn99VoXilLPVbfKCBemGxQwOIBWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019027; c=relaxed/simple;
	bh=P85/MLXEUe7QF+fN8WJZvrqUyH/HIWgCvcG6iXlJUpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg5/ZFdKEgjPaTj3SAT4HvzcDAqGoCdIxrS+Ys/lvQEHO6GxgK9PFFd/O17zTt5lasFFOe2Ay/fumiaWMYq2S6xZAMMVymVVm9TbEWIPTgRKrGk5dRoduWg9B+KBXrgGIVhTaHvdudI/LdRKu6jZ9tGhT9P94hl9FWc+X4/Me6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k27jODSf; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4db385e046dso9191521cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760019024; x=1760623824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P85/MLXEUe7QF+fN8WJZvrqUyH/HIWgCvcG6iXlJUpI=;
        b=k27jODSfR9j+LsK7N2YaUTKlTotHaXWuVLwJQaj3yHl52kEGC/FnkWlwEayXeXPYSU
         73CqZMmAnU7cEp9T5MCUCx9v2jC6yzCOhQ0E3VWVXiZHi6NV+B5rimtj9ZPtovsrr2Uu
         R//xfqLzuZIFTC/ZQVWD37bn7znte0YK4hMYwqF9RvuoZr6YPPNnFw2S7rmfr14RlC6i
         sR//tCs8SeJLAiAEZjN89A1sBqsZR4TIbhL2SfEp99nLsz1/C1Bla0tttc+azAcC59TT
         Jra63A238f5I4QhHSKnaZVoiMWSSWsO2hIEL+FHirqt0C9fuA1+MuyfJwl2MsqaeltG6
         64kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760019024; x=1760623824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P85/MLXEUe7QF+fN8WJZvrqUyH/HIWgCvcG6iXlJUpI=;
        b=AOE7KS2ogiJmoK0M/31T89+ZQODmECvZpk04NDWipMpQCd/JuBRWPl1ckW31VxKlg3
         Yl6rGiNmPFDsyNr0bzBg6jzZmDXAa+zPsbPdgMsuP9sO16MF8uB9lQ6ckBxHigj/xPGs
         eTbrK99fmE9fmf85N+fNXqIVLTtBV9NHVQHOT3QOwyvYpuillIzPKJVsJmQZLME8T3Ya
         BY+x4qmpGqRN3Z6Ds9qt0/SMKxJRa7zz6++8C/EcFY9fQqm9axyUYtWt4q1C2CvvEypR
         GbjZsRn+BsvCtGU9+UQhM7Xbh0xs2q0mcaFuReyHQb+5rVOZepttY0DIUJZcp7usXTX3
         w08g==
X-Forwarded-Encrypted: i=1; AJvYcCWD+4/G2Km+KJOOhGR+Snllcz8nWE7juu0CMjoO30TRSXPuojBYj4442A50XevzJb2GdN98BF7rXSWGTkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfl5zl1F8+Bzy22FGpKsFlyKFuLp7km9tMoU9KpJaK3tJ1Uac
	YLEn+XUPYWw4rXTBW81Bkx10CIxz9ScaA8UvmVMG55YSNdr+7xVAkM11WS5Owwu9+9kaaaCT+hU
	LMrvVx4pHal8dd6KsvcLxRe3QKWzqOHc=
X-Gm-Gg: ASbGnctHtU/L/Y4z0nf25Q3dCo+msZORohcawpt1AxgAb7o8rANEELGM7cJDce6orbF
	9D+R477R+wMtwcOC/B98W7ANKr3IOgJD37zpw1H/y+c5wyCUlbSQNp38rjyfnVKLU0jj+x/ZpB7
	LMX9bQ6hHWfWAcgEZ5aa4N3og/JMHwu4dEpOHQwb9bdjIPFHl2owfM8eWr7nycylFtlsZfndg5q
	MOuE7vqPyZM6dwJ7rsWqNDna3PhMZeWvP09/SrzYr/Kv9EWO+DOlftXa+pAWVOSjElkbR2HO030
	xCB+2xATwxTNfk5pjcbGp0SYoh1Py9PfrbspXjW2dDz2PtmCuirtdtdLqB6jiKRtQT+L9KWjJ6k
	rQf0RB1XrQSTEmsp0fE2y6KTLse8SZs2ty1Sou8eMCX+V/u9BUiDJqaceE7yIOTQk6pI=
X-Google-Smtp-Source: AGHT+IEq6CVbLtM0eoAJtvMfbqXt4HJ2BgMlkQY9gDys0e20heLVjsMO54GaAaTrR6eS4pO1ntG7gQ4e0F3PtUvAMWo=
X-Received: by 2002:a05:622a:1815:b0:4e0:3cdb:d1dc with SMTP id
 d75a77b69052e-4e6ead4416dmr104621181cf.43.1760019023589; Thu, 09 Oct 2025
 07:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5b95806a-e72e-4d05-9db8-104be645e6e5@web.de> <CAH2r5mtpoLscs9sodXcRMO3-dqMDBSTR+ncExdqy4dQR=4uE8A@mail.gmail.com>
 <bc8f02de-0cd5-475d-bb19-e44e202f7a58@web.de> <CAH2r5mtY8--9ccnm5aYfOYJ=kEBr7=y-Z_eROKDp7A6DGnxwcA@mail.gmail.com>
 <5c09026e-3176-4dd3-abd8-e5ef3b2bf5c4@web.de>
In-Reply-To: <5c09026e-3176-4dd3-abd8-e5ef3b2bf5c4@web.de>
From: Steve French <smfrench@gmail.com>
Date: Thu, 9 Oct 2025 09:10:11 -0500
X-Gm-Features: AS18NWDXka1aXJboBSZTAkvYpbLFoOs9n359mdD7fdpj0FKFp6jbH8uCrZTjXDA
Message-ID: <CAH2r5muYzimR+i2EBFwvJQ4MWWpzVdbaocg+8FdSniSZF7rXQw@mail.gmail.com>
Subject: Re: smb: client: Simplify a return statement in get_smb2_acl_by_path()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-cifs@vger.kernel.org, Bharath SM <bharathsm@microsoft.com>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:00=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> > Three of the four you just sent today, grow the code slightly,
>
> How much will this observation matter?

Remember the goals here, the priorities:
1) Fixes for bugs
2) Performance improvements
3) Features that add support for missing Linux requirements (e.g.
adding O_TMPFILE or "rename_exchange support)
and then lower priority but still somewhat useful:
4) cleanup patches that remove unneeded code (although has to be
balanced against how it can hurt backports of important fixes),
ie cleanup that makes code *smaller* and therefore slightly easier to
read and maintain
5) cleanup code that adds or updates comments clarifying confusing code

Obviously "cleanup" patches that don't shrink code are often useless
(as they potentially break backports of patches for no value).




--=20
Thanks,

Steve

