Return-Path: <linux-kernel+bounces-876749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C4C1C5D8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14386432F6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020462F0676;
	Wed, 29 Oct 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1nadL5U"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5B2F3C39
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755907; cv=none; b=k//l5gHYfctcHbDfwO0TPnsoBCYQ58eiSqH33joTWcW31wbllToUR2ab5qmgM2B4UDrSFVgKMe+fGUQtF2a0afTEj4Vm8wWIhybe0fdL0hm2DYw4GDemLAHrnrghDF7tZje/N8lNpF8JURcRSCQy76VzfksqODJ6N03ZSccgA7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755907; c=relaxed/simple;
	bh=Jwdv6/9meoYUWvOfN7SO9jrpugknEVlmkhDpfiFHKn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ6fNmiQBf1K2rOrMhRgoEib3BkXttmpn7JdjXX6W2uxpPjg/a19LEOB/C3VbaGjeelU6BPzv81XM4zwTVBhs5sUkbXESQGuZk9/dzXnQLU2c4+UFWjrR3zBL4uNDjgTq6vJy0sY8vI3NlvdCxdrr3L1sKnqNrvFhi8adu5FGes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1nadL5U; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-427091cd4fdso30557f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755904; x=1762360704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jwdv6/9meoYUWvOfN7SO9jrpugknEVlmkhDpfiFHKn8=;
        b=W1nadL5U2bSeY+TcybSfsiTmgoOo1IBL3eWyzAmk+ejKJLex8rTwklOpr5Wp6tbIF7
         vlCCnk9+GP9GAVg6ht+UoYBWX7I9eKQR6e+Jwh78ZZKd7W860tD3onMfHsE984SionrB
         aHU+/2Irpe7vs+rq1CaWv3kMktI99CgtgB7vpKQx/25dRFefirSHj4bGdQFtStBr/aCK
         /luzX45L1aDfa8+Gs5PzSfj67m58UpTCvyN0WBUpc6rHg5+ueLKSqBegSV92jrpsUexs
         zffEuiqF+t+IPqoWUEdYAJnU76BdL4/Vr0xXp42MHCyoy3hWuKPemWM7vXYwE6hN48wX
         6zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755904; x=1762360704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jwdv6/9meoYUWvOfN7SO9jrpugknEVlmkhDpfiFHKn8=;
        b=ITJ/hRbx3L26pGUt/EKjR8SsD6MWXhJXiT70jXcaB/CX+n+ohsEX4YyB0lpgLTLo5k
         hg9FeRwgO/tkiFWNjgdvA6EOvNCLQA7wuEKArYa+phjyWt0PU1ZbI9V9PfmH+KCa2QQ6
         3g3iSa8HIHjXZFXZkfhQuX0Zg0mqw/GU1BsFwogM7zBbl/6kzUQcxBIkTT894tUQMOxc
         4VfK0bhw6OT0bOocvmnvgVwh8s2Q3snPQZ4bTuKeN/tuDhk0yMpG7MK214qONLzIqqPI
         km3Bm4MRJ+aswCYIdolFt/DWY4IQbZ1ZBxG92j6bx2y2AiEgxVoLZDrSTakHBCM+rVNI
         YtcA==
X-Forwarded-Encrypted: i=1; AJvYcCUoYw4OPw6PWWQzxo0P3ALYvpP+QJrEx/kjPeWoAWCY8TBRtQAevktCp1Dx7n90AlB0TnlQcUcLl5S468E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1OJPBJytaz3IIn4b/HD8k2NyiYEWwZB4vpyv/Jz2q74hD+db5
	JcjUd2be7jewDVdUq4KMFRXOjci/u+BoCTEUGk0fHfBWdGpwG0UKqCzGZmT2nkJ0yAL0CFV/clu
	e3C8GWoNJJUdVxi747rbesceR+t6Op9w=
X-Gm-Gg: ASbGncuAZPCFVK4kWfFNORBd8o+z8zaVBSvwaCTa4kCnEXRsHiZw+Zzk80KC7ykAWdO
	whpcAvV4JiCAzU1qLQ3cEufP7wonyixRDLp0Mk+NlOfI2odZ1DvcHPNNk857gh1hQPMKzsFn/n5
	m2hj3FSJUSBGXcLP9SDzNQej2/wAo5R/08BBgIgdk07zBNxAiNhQaRzSYANEmIEL/yxRtXf10+7
	PQGi/SwJLNAzSZNjsaBnqEA7UnPkIQkXy0/vev9HaXRDcQaPzx9Qn5ZZ/lFTUKBuIEu13HkeS6J
	2KOeEaeX4RL/bHjbLS0feRLbPXsz
X-Google-Smtp-Source: AGHT+IHOKbYQRjb7noEtg9viqdiV0KOSoE8fwPGm5DiruA+2k83MA/tyzn39j/Xj8DclgnRtviyPtE2Cakz8DDAsYdo=
X-Received: by 2002:a05:6000:144d:b0:429:8b44:57b7 with SMTP id
 ffacd0b85a97d-429aefca83emr2893529f8f.51.1761755903765; Wed, 29 Oct 2025
 09:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <176167501101.2338015.15567107608462065375.git-patchwork-notify@kernel.org>
 <CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com> <23eddad8-aae3-44ce-948a-f3a8808c1e24@linux.dev>
In-Reply-To: <23eddad8-aae3-44ce-948a-f3a8808c1e24@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 09:38:12 -0700
X-Gm-Features: AWmQ_blZBI4M6hqka-WDWjrJS6mwNo50xI2IEFe-TA0xh4CdlMem_GYEsm3tD7A
Message-ID: <CAADnVQJHAxKmhDdJ_SkgHMf3adiS8MmD5MJCfiFfxU+8peT9-Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/4] bpf: Free special fields when update hash and
 local storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, patchwork-bot+netdevbpf@kernel.org, 
	Menglong Dong <menglong8.dong@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:50=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
>
> Right, this is the classic NMI vs spinlock deadlock:

Leon,

please stop copy pasting what AI told you.
I'd rather see a human with typos and grammar mistakes.

