Return-Path: <linux-kernel+bounces-853001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62894BDA68E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C614D18834D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B773009D3;
	Tue, 14 Oct 2025 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcJ/1pL8"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436CF2E7F39
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455976; cv=none; b=At/y2rvDSZZTLI3uoYLy5/w9JcBHRMQJZyT7A8COJ9yiF30zwVRlGSsYrmu8AwTo8fOlX9MHmTSMGH0IP+gF2Je3fKxtc86RAuctfHRpWm9Ns5cOcDbkiuOfMpygwH1qo3WdVEK6bnR5t2QS6xDKWalT2h/mRfcs0PVgWWcy3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455976; c=relaxed/simple;
	bh=ffMm7Yz/8R6++TIbdHHyZXzHcqpQpJ572eW2FXJszR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hz8zbHonYosgcKUqyEaTiAiCcVG1nlHpG5TKgUTbfOqPTkk/gECogJB4PuqzQEoCJKxTuHGpk3b6pGRJ6Af+f7f4w5oWpAW7ScI0+Riwg7M5FLFM9jPi8rlWwwN11/+7h6XpeZ9yKTAZ9WeDopxiIEtVyYMqUMaxqFE8UEAoThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PcJ/1pL8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d67abd215so700445ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760455974; x=1761060774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffMm7Yz/8R6++TIbdHHyZXzHcqpQpJ572eW2FXJszR8=;
        b=PcJ/1pL8zTXfk3aTpvgu0mrwCv2yCcwb6wEI8GP0fvjaAYq5lKK0GaMJuB1aIzlS0Y
         PAgMXJP/qYmmBXwM3XzTHwPiNuQsRm3YZhp2JiNB9ZCUL8STxtwsUveMjKpP6nwIQAHz
         J1wtdm+tFT3H1LVs6X3qBdjQDaxDTeIIdav+3FX670d5FsmdKqkELy9UArfRzEDR/Ltr
         yTwkCsQ1b9xEpCZSYBVXeOkGiRjrM1L2pXQYQ6rh/CTdwh1er+p7jTsaBiKq9/uzonfD
         ZaPUqfgsWk4BpX91o4wt9q6qbySBxvr62lUk/m0C4NePCs40jeLngffrZheFZl+kXVI2
         TZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760455974; x=1761060774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffMm7Yz/8R6++TIbdHHyZXzHcqpQpJ572eW2FXJszR8=;
        b=hUuA6VTJjIjJMs8Se7YDkHfUmdMG8XkC+B64htg8r39jRUoJFSCQaMIYdQ7Usi/Tu3
         HA92XOBKEv3T7C3viExHsgwgjQYXpZFgVfiaabQKQhC1/PEYLWhlvZG4zcWNLF83gtr3
         oN3dqcPsbmbQ0VBteArU1PYEwyXYeGz/BBaoyd/2Hl1IY/0zMzYvO/znBDUlkjXeWKpI
         7yXUMq6Z2eqkAclMJqbHpX8WRvB9GCzQwqPZJPdH76DeSaVXGwDh4keO7J8uB2sZzTCU
         VXH51/w7izZBuxOv5j73N/beB3eqdFV0utQxmtvfnMCt/fVll/y1N7AWvEfD8BUSuiGY
         2xeg==
X-Forwarded-Encrypted: i=1; AJvYcCVtZo6/nU3ceGHEqtq4bGvF/zCERoOLwMXpLm5aEy9LyxbVVbCITrL9HjFMtPSg8VHfKGP/Lba3I3tu4TI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1fuqXI0E1TjjjwaaCsRZ9KQx3JE57J/b9tTxitZrqBv1J2rOT
	0fwbZrEv6UI7xR0TfV0C9tI9X+kAtwQ3JgX4m8N8EGwUAA9iSrbqUKT94U1zWlJFb4MCSmt5P+k
	ITfYT3iqE5YIGeAzwrJy/c7H/VcnyNitqq6Rq9Ptk
X-Gm-Gg: ASbGncuHBlLcC8iAuzh8hZQla4529ascqR+g/7oBL5Cv4Uy4fk1oMEd2/sifEsWAkY4
	VntLKNO6UnXOLAh9NyfnVtqL8Klcl02Ik8Pz8Mjggfwsta8OmZua70V6ouiRPLPwtwFA7/4I4xW
	/5m66cg9iWoecGf7yIrDZ6tzRB2XZ643tMhQCM7MrEmeDj2axO/LA6jXFTzrSduhTd4DCrlt8ta
	TJrnMRI3Pddd9B6j2XYQ7U6uZKq8gJ6r3KfRf90RA2JvGTCGWEELU63Gxo6JoK1jg==
X-Google-Smtp-Source: AGHT+IEAXjuXRHNCvILZZPPXn4sZcsg04QiZ30ePy7vGF1dqT989ZMiDUdgA08TDD1m+Fpg7VX5rBjRBfRSp65lsydc=
X-Received: by 2002:a17:903:38cf:b0:248:7b22:dfb4 with SMTP id
 d9443c01a7336-290276dfef2mr26574225ad.16.1760455973795; Tue, 14 Oct 2025
 08:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001025442.427697-1-chao.gao@intel.com>
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 14 Oct 2025 08:32:41 -0700
X-Gm-Features: AS18NWAyr_emv0Wn0qKZu1kQ6rVRMX-wPuzsEhtIUlCqjC0fqdcjdn3Vc6NfpwE
Message-ID: <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org, 
	reinette.chatre@intel.com, ira.weiny@intel.com, kai.huang@intel.com, 
	dan.j.williams@intel.com, yilun.xu@linux.intel.com, sagis@google.com, 
	paulmck@kernel.org, nik.borisov@suse.com, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 7:54=E2=80=AFPM Chao Gao <chao.gao@intel.com> wrote=
:
>
> =3D=3D=3D TDX Module Distribution Model =3D=3D=3D
>
> At a high level, Intel publishes all TDX Modules on the github [2], along
> with a mapping_file.json which documents the compatibility information
> about each TDX Module and a userspace tool to install the TDX Module. OS

[2] mentions about a limitation of doing runtime TDX module update:

"Performing TD Preserving during a TD Build operation might result in
a corrupted TD hash in the TD attestation report. Until fixed in a
future Intel TDX module update, a host VMM can avoid the problem by
not conducting a TD Preserving Update while TD Build operation is in
progress."

Do you know if this issue is fixed already? If so, what version of TDX
module fixes this issue?

> vendors can package these modules and distribute them. Administrators
> install the package and use the tool to select the appropriate TDX Module
> and install it via the interfaces exposed by this series.
>
> [1]: https://cdrdv2.intel.com/v1/dl/getContent/733584
> [2]: https://github.com/intel/tdx-module-binaries
> [3]: https://lore.kernel.org/all/665c5ae0-4b7c-4852-8995-255adf7b3a2f@ama=
zon.com/
> [4]: https://lore.kernel.org/all/5d1da767-491b-4077-b472-2cc3d73246d6@ama=
zon.com/
> [5]: https://lore.kernel.org/all/94d6047e-3b7c-4bc1-819c-85c16ff85abf@int=
el.com/
>

