Return-Path: <linux-kernel+bounces-880353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8228C2595C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76A894EB927
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E034C12D;
	Fri, 31 Oct 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekBb1BvP"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325B3271EB
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921097; cv=none; b=IFXULvlGXpt11qBpA8ONP271vacwUEal4fL1Sux8o5YTt1Aq4dj8SW9dGwmyZfiO93fcNGuJkr3sM31jhwstghHNztENXxFM6vXqk6qaHmqFzVQbspO0LaSlzkGeDMR2JTMjJIkJXq++sxD4ajNzIkNRyFXvukcRmtfZmyda4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921097; c=relaxed/simple;
	bh=ncGbPazCZYRVMKM/k7v7Zi9/MqF67N4ANYFa0XpW/Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UE9ztvv+sOhctONSIYpMEFrQICoBi0sYEJ2uwTDawXNCFdjz0/JTvdJLp7ttRoem+F6PzHRGPqDw5WEi1BHuOICdlQw3SN8baCa55EuhSTu5M2L9WqPVtR6Y/HUL3qukVocLljJ1J4AYxbqdZucP89JRTUXEFGZeDiCyILhjaik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekBb1BvP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so2280268f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761921093; x=1762525893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncGbPazCZYRVMKM/k7v7Zi9/MqF67N4ANYFa0XpW/Ig=;
        b=ekBb1BvPk/4XQppwL89S83+HVcOJ44UixxLR+znuxNZCQciqRLvtDAlTxyjBl2eXeU
         8Z+remJhUfWN7gOxlsge3E5CymQXh7CnDymgA6jo2jjyfFf8ekO3UoLxYNiXrll4CnO7
         A0Xnsaj0CMp1tLz2rSzP2IpFU/vvEw4hpK0JkeZ6+LthfwW9967Z+tIksS14pfVJ4NtM
         1Ra4jaMRNp9WhpmV/7riXahV4qhZqvCuIaj6hqbRC68Go/9b/XDrh00v7t7dPDOGgjdc
         1fHEt80IepOHRuGMNpR/pOuOinbTWY3kovV6LHNnhxZqSHKNXXZTHg9dzvwNKUOBTav3
         JVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921093; x=1762525893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncGbPazCZYRVMKM/k7v7Zi9/MqF67N4ANYFa0XpW/Ig=;
        b=JvH9lWf/oIXJt9ZTDvx2isRRw42Xbsf1CAh9x0IW+8X2OsHBrkXdp2B37SJYlNqBFM
         6nGsvO+7uVkgutQhXW6Rp+CbED6Yu+UDZJBbIzIOKSXykzv+ZZSuBxRP01wJmngDbNXV
         jbB6I6CTW+jdHCQPLRzc8iacbqQOvtbixl0t1OdpytUG/rmKYdBjJaIHz3viG9hoomdg
         9Arld5TzFHJbB8QeJyvrWmmitb5lNB37MHkRM/TI6mqNy8VFeYfeY8Bw9oDuIzi1cznJ
         lOigJrtxruLgmfuXiZO29uRo/HDOgn23viePtZs5wd4nVnreAJfhJrBolmV2WeWoMVW5
         udPw==
X-Gm-Message-State: AOJu0YzZwH6q57PTm9NNgBs01Puehz5PLmIuwUaYlGU/YIirAIzyN4O3
	ZXw+AhaoMWU4dOHZMpdWHP/0+ib+PVQADLr76I9yCEiqfD63fDdqOW216gtJW6j469oI0A1QBEO
	rqMuR48cGwh0tVZ1+cs0TTELApgOb7iI=
X-Gm-Gg: ASbGncvybfdXt+0cU+5LfLSzmZZexD7PTv660lqSEbPIFktBfA5tTDnNTE9RVEopzK3
	mlJdgAst6wlpad2QN9Ylla29IOAQtBJuyaKDY66ofHXH15mzReubyRoSwxDx9+DhVpps27pFlKF
	KtQtSOeFZK/X6Zf77VFyPOCLbfqTDHZjzrIN5uevXkS2/4vX2wCTk1CXy787T4dUjIKdvaR8WTu
	OGfqZPHfBrihprmnafETusuuo+h8OcHKnLg9AXJvICndP0T1LX2aPiNp45RAMqTbAdOu/aKKFtT
	PNMubjVqmEDMYMxYcg==
X-Google-Smtp-Source: AGHT+IFiAqK/+Syn9mgwZcO28zXvwpfW9s7eMblmTPyk4lo2e6ZewS1h/5hEgaWteHfEGFYUaGs6VLJABfpETB39Bsk=
X-Received: by 2002:a05:6000:4211:b0:401:70eb:eec7 with SMTP id
 ffacd0b85a97d-429bd6add28mr3046896f8f.43.1761921093400; Fri, 31 Oct 2025
 07:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031075908.1472249-1-jianyungao89@gmail.com>
In-Reply-To: <20251031075908.1472249-1-jianyungao89@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 07:31:22 -0700
X-Gm-Features: AWmQ_bnkIg3K0cArYapCkNQ22ELaPjdwF2hB_Pz-BAsAugJn3W59knHozn2meJc
Message-ID: <CAADnVQLR2R6N8HvuCKk696xkSZV06QJA3_d9Q6BSrf3MHv-WuA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] libbpf: add Doxygen docs for public LIBBPF_API APIs
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 12:59=E2=80=AFAM Jianyun Gao <jianyungao89@gmail.co=
m> wrote:
>
> Hi,
>
> Background:
> While consulting libbpf's online documentation at https://libbpf.readthed=
ocs.io/
> I noticed that many public LIBBPF_API helpers in tools/lib/bpf/bpf.h eith=
er

stop this spam.

pw-bot: cr

