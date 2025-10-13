Return-Path: <linux-kernel+bounces-851570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C6BD6C92
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261733A5426
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037872EB865;
	Mon, 13 Oct 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV6k6MJ8"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9D271459
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399614; cv=none; b=J9fbKUl5E5PwlWnptl2O/zjlDx4hl9YxfBIHZYWaJ3tnFvcBjPA43F0KC6g1im0xKz2qGe23F06iLvB9wOZrataD/VUdoh9WGppyPcDKIErbzZTCJDBBYAxvKPV40dlLc9+iF5qnJJ6Ehj7p548zIDnYMhsS0NFJjGoKofOSgdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399614; c=relaxed/simple;
	bh=RIEJrE0uCmjzvjs+seL8p1hc+jZaxiG+Mobd5Medcfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilQZzifGJq+cuVhJhqk78iEbzkZEbQ4BPe/IzBCY2bYcDQJ5czWa3hKzNgosZAzEWEYJcexP2BvmIMWaxMgWlHJm22d1MLRXgUTVgZlYhlmOsCzjvtOc9cpIuTIaKq3qgI+XJulv3HhcfeRIqs932qaJA8ipnCB43S1ztVyZydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV6k6MJ8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so40702155e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760399611; x=1761004411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIEJrE0uCmjzvjs+seL8p1hc+jZaxiG+Mobd5Medcfg=;
        b=cV6k6MJ8Lkf+6yirLU4QU8uGgecETWdcE18APqUPjQ0tZQ6CIB5a3JifNbS1uMf19s
         EGOD0RdmRDkyptiaPBWXE8VljBXcJizxoSX5a1y0TvOQ6+jgrzdpopELTuB3WBLMvhuV
         81qjF9zVs/jf9GH4rOXpeUQKYbnq1b+6+ELgkGYR3nUsvqgr+Vg1kP7nYZxanGiAStgd
         /OaRUVSCsKunR7eHyHUMHWcb0xI+BoI9afEVAKSEeV06XDqMVORTC2om5+WDr+ml/j1C
         s9KFsPlFOLrOYV1LyQygoHvdsv9CvAVoEZWH9a8VTDx0bt87Hsmhk2l79ZSZtXaLs9y8
         W1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399611; x=1761004411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIEJrE0uCmjzvjs+seL8p1hc+jZaxiG+Mobd5Medcfg=;
        b=PMgx3EiFakefd24JeA2J3gwEEr8qJwwF1l3aHvZq92ou6/4fM760hr967jPPYnbqxV
         KwINmI3N/9onERCnIfYo+oRUsP6XZYmn0DsuIUIA9RLhXQtijLTpkzZ9g+NLvSoSHBDU
         6CfHUX3aUX9K8zI5iwYtGJ6jj/gRdgAIQuFRUHPts0DYEdwh4q6LD6nWloTKGM0azeCU
         vNLxmY3kdiO86O8qHf61E6yIfl/phE3j8v2U3vl5ccpWhN4NfCqSN1Wc7xoVVH9XoCK4
         LZa+mWLDSgd+nipWMJsTO9/v5BggtG49Z/zClZislt5qvRDGcA71YWaXZjAoWUgJzQh/
         50BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOkik5/nKrye9+pARX30RM7Y1Klq2vrCoZNyh1cPmcb6oNWIFKldehs45QlYlBWOiIMcJAqhWNk5+YgQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIKXyX9NbgzI4ll7dDZb93xBhp+JTKJAlbPr7TsNVYZl2SGbe
	QjW68wFwpKpWQgWmBu5PTtzoYwq10+kby99TdbbGWc7VvtCDWUyoB7URTq2rVwNMm9Ig60i4pzK
	XivlXEgHhfHrTzdDZMbJT5SVts/tqYb8=
X-Gm-Gg: ASbGncunuCgQbaikwZeRALsaBvtRd01OKgU/tnFg/MgORiHLu+Gs1CZNdYRr9BKp4o/
	UwbKe7xO04K7WcO1eV3mhkKTSY6wZSzquIrSUjFqEGIntrKr29mhQ2tknq/825AbU67eVsyPxne
	3QUMEpgOjI9u8zc9qCT2aapJT6EANmB/UXHas1z1JyEfACn+jyeeNKkOceDFUpmAfLO/8WSXJkO
	uyuSygjttVgiWOhXyC5dKo0J0WSGGWBbCB6e1ld6VkPIJaFd0XLmRchbsK94IuPnC9OJw==
X-Google-Smtp-Source: AGHT+IG7qgaqiANTI64fKq5fdmN3jYIEH7WORYmY4wbj4MgVRoihxDtESxflM1JUMa9Wy0M8r0UWCelXBUFZ0Hk7+LY=
X-Received: by 2002:a05:600c:5028:b0:46e:428a:b4c7 with SMTP id
 5b1f17b1804b1-46fa9af2ff1mr156663835e9.23.1760399610941; Mon, 13 Oct 2025
 16:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com> <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
In-Reply-To: <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 16:53:19 -0700
X-Gm-Features: AS18NWDSXnedfjS8OY9WIaDlY9RiYWa2my_cqlC8rCnw82wSbTJtgr_XZ-TyNvI
Message-ID: <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Just a few observations (if we decide to do the sorting of BTF by name
> in the kernel):

iirc we discussed it in the past and decided to do sorting in pahole
and let the kernel verify whether it's sorted or not.
Then no extra memory is needed.
Or was that idea discarded for some reason?

