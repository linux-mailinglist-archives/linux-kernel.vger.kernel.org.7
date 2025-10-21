Return-Path: <linux-kernel+bounces-862419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B23CBF53BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17EF7350DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E2303A15;
	Tue, 21 Oct 2025 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAxoEHRc"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7D248F47
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035488; cv=none; b=ZgLrONmWZe3ZPR7IOHMDkgpzcAQ5XQiQAvCv/WJ01IXxFeXd4EHPjFG0Pu/n7xzyElwQL0lgmEWFHpCPWw4v7IWBduizvejWxm0rt2TXb7zDsX4GsTsAMKCCU8G+D1jHfiMnuty7kLQwsfmuGzsxm175VRukhn8/uSgBL2U1tSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035488; c=relaxed/simple;
	bh=kZFjKIEcnkK+8h+RXTYyyktt7Hh5oNWxVgN0IiKcNTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCoVyHu94FW9yUAl8A/vAGtcTmuhAKu6vQ42+2YzdM9hnI8+C+VXJhjlbf+DgV/gfPEqlrK02yTUo7ZD750++1ezaESp881fB6qVg+r4yHeLipNCzL6CB1HYZRSaLzLaE2w9LbESMb6LPBkB9ZNLxkWjxRmPYLKfYvhbg8Ic6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAxoEHRc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3d50882cc2so1004275566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761035485; x=1761640285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRTE5Pag0LzIfawiXpHT76EYKoTRi1+EVw3LVXs3RXU=;
        b=eAxoEHRc0llHF7PUdbCFzuxmeJI4eEmtj5j3Eh5xDuOy3+Vmahw4u6f7KbhnRnnaBR
         4kYHMd6AJm3Ro1pC6JNKyZTea06HhVhT1IscgYJehu/T4EL357u5JJOyAadoRh0/pWh9
         lKc/Pvf391aw5MYhp0SfJk/w7sbTqYBOeR5y70ko7Z7mDgXaz8VdBHlIYDLyJ7ftMIDl
         UDEHDasS15N/kWu9YYskwKAO0LvFCYpY+zrWJhP9XxkKdzMQ0X8WV7HjYbkfx+H8JZT1
         fcVCwxQfjO8tt9+hf2BZoV7G3Kz8riAZZ+00BcUZaW+R7lb7hDa9M1Bvbrn2tjePk4Sd
         EXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035485; x=1761640285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRTE5Pag0LzIfawiXpHT76EYKoTRi1+EVw3LVXs3RXU=;
        b=GHBpAtd5gdCUuASZUfJ2QAUxrodlKyZA+eVvrxw3GMCEU7X6noKAds5YxVVBcGw/kA
         8p7RqRkzq1oAXjb0zHeoDxYFwiWIeHcPYE7G2dnkxAy023Z+tNVwGg44dRJCpJBDKQm+
         fce7IZfMBxktWn7XpZn2LCj8cfGuiIUPl/SBtOT+AnL2TCNgBVXgwU0Hr8CQ/J53UXPn
         +CwWgRd2c84KKssqmYF0yIWtwCLC0uPNcY57hPXLluWkf0dyLbwVRnbVCqmckjMlvGE5
         T64aKFB0p79GrXz/nfXPSLAoFGEpAB72Qb61LCCSdmFt12qeBhXFSSyrBN7MLXW9fFzU
         kphA==
X-Forwarded-Encrypted: i=1; AJvYcCXe4Swn1365/UmBIv6gv8+6hYQ5XiWzcA5hHgzLIICYA466/xmIIyPtKSGzL87MY1InW7d3Cnp4pDA1waA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPwz9n5xhiDAtXYEehwstQllDurARKOjDrd3L+lvN3/WScDL6
	+Se+ejuzkBzA4bxeAUKOSa+uV4Nw8rDSOGiYAgkwjHGyyAYWAcHZm+bHmoqYMgdpMk0LxRNVNMK
	VjOaZ/viGyq6RZdef8BsnPmdpGnf+ZXQOCCkaSAE=
X-Gm-Gg: ASbGncu0FvcJbauiJGWS2HobJjUp8Ez21iu7FvLvWoHuz+aX26GouwurEczHvkd0agp
	fyxl5HiZP6mVEzXcYKIUyGLUGZKLBG6ZnYqrjv0XPjBxF4yzbP1hLUTVe6S1M1apbGCwmCc90WG
	TxAGROQ6ZJdAlcGvroUC2SnPGd943dvXhcV4FchDoAMM+Sf2dgqGTIlGkztuFl6Zt7BmxvU4yeL
	PUgPsHw8P0vQGxkb8Pt9OjgjdUXgY8iaROyiq58O7s/PRePKu1Ykb3eMz4FLg==
X-Google-Smtp-Source: AGHT+IFdZlBla3o+1d56zY2FWC5VJxuhXSeOUtlMWami7zo43RDALaBdxTKy7BK6sgH7dr2GmAOIyoWD0yR7ffvi+7U=
X-Received: by 2002:a17:907:3da6:b0:b5f:c2f6:a172 with SMTP id
 a640c23a62f3a-b6473b51d50mr1965498566b.30.1761035485271; Tue, 21 Oct 2025
 01:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-2-dolinux.peng@gmail.com> <76e2860403e1bed66f76688132ffe71316f28445.camel@gmail.com>
In-Reply-To: <76e2860403e1bed66f76688132ffe71316f28445.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 21 Oct 2025 16:31:13 +0800
X-Gm-Features: AS18NWAIKqzH5h7jsu58rm_kdFAE4-AHv8xbavdE_JL2YTnu5uqCVNy3TYbyJ74
Message-ID: <CAErzpmvLR8tc0bfYg6mG82gqMSXHq_qXeMsssSDuzirxkSt-Rg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] btf: search local BTF before base BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 9:06=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > Change btf_find_by_name_kind() to search the local BTF first,
> > then fall back to the base BTF. This can skip traversing the large
> > vmlinux BTF when the target type resides in a kernel module's BTF,
> > thereby significantly improving lookup performance.
> >
> > In a test searching for the btf_type of function ext2_new_inode
> > located in the ext2 kernel module:
> >
> > Before: 408631 ns
> > After:     499 ns
> >
> > Performance improvement: ~819x faster
>
> [...]
>
> > ---
>
> The flip makes sense, but are we sure that there are no implicit
> expectations to return base type in case of a name conflict?
>
> E.g. kernel/bpf/btf.c:btf_parse_struct_metas() takes a pointer to
> `btf` instance and looks for types in alloc_obj_fields array by name
> (e.g. "bpf_spin_lock"). This will get confused if module declares a
> type with the same name. Probably not a problem in this particular
> case, but did you inspect other uses?

Thank you for pointing this out. I haven't checked other use cases yet,
and you're right that this could indeed become a real issue if there are
name conflicts between local and base types. It seems difficult to
prevent this behavior entirely. Do you have any suggestions on how we
should handle such potential conflicts?

