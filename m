Return-Path: <linux-kernel+bounces-869533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D0C08194
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275E93BB47C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3492F99A3;
	Fri, 24 Oct 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDWPNKfn"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF62F83DB
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338648; cv=none; b=EMms+qRBLpxs9qQ4X+964WHKSPKn/FKWYKMqA/U9OXctEW0/K8pw6QZG67oDvFxkPlwVeDjgZ3y9snfcbNfx0tOQgBloURx9JpX+MBJaX5gjJlywW7ZgmVfU4e//jokkxekrTxRYv/reSPmhROIjJ63cx9+F61HmB5hAwfgn7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338648; c=relaxed/simple;
	bh=RNvLYaINM6n6Q8orahjUExiUrP2C5m6sUpUU/3kkhqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mq9kpifhOkHZo1FB4RevVzQMkeTZ4X0ClF4Nk83Nhx7f1FGBkusSbDLyHuyq8aovf5u8QDwtJQaTXWgJr+D4MxUtBNcQk0O7GOT3o9tnjFk+32aZFpbiwCVDTHcjpMYZDnCH5mVJtWVujRmdReebnZ5s70ROHY/7WomEJjrm2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDWPNKfn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1905314f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338644; x=1761943444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxHcVaFJP8LSAUbqjjuozojLxS3r7R2EKYoJfzV0av8=;
        b=PDWPNKfnvOhNrpgNr1ziFcM03mI+9YAvFLQAzHSj3aDY34JkaBkH9tC3AFFMKPOP9K
         9kQNxp2nOcYfiKGF5kvvnNuR5x/AXJVMoI64cH7TWP5IIYvqRJ4QO5Pt2WJEwvhuDFAZ
         5iVb5lbJPASH5XKtCHouixKHVfroqrcwCWERpMIpoWCSz+mpZc0Nu7ElmVOlpyfpDyHv
         5kd8b8HdQWoNyl2h+KlslQW21M+sY7ZhWNQ1QbIjZgTn/Eae8UpDtQ+5FaFYY81E1p3i
         FHHcYD7OJztPzUefeU8NF9+eiw2KO6YXqunXYNlMvWJraKDjeK5SVp6VxI0h2Oo+kZLL
         OHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338644; x=1761943444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxHcVaFJP8LSAUbqjjuozojLxS3r7R2EKYoJfzV0av8=;
        b=xU8mdXxkMCatgY6gML9swi8r+G6pDDlxbqMMTxSdrPcANdrVenpQOz9wXPjFbInoR3
         5g3+WYCogmDhNgWsEzhvyWA6ZC6+LWFNf6NuNI0R70+J5ptUtA1TmfpctdHKTR4S80Me
         fDvk0BtpJmWVYFyKBVBamQkufJ4IFsXlLAPq7mD1SvjSx/bKstRRpjp8egKiTryFTRAR
         Vw9iS33ESmIs9X3z933U7EsYbWqZUfQV4RreOe44bL0qxDMim/t3qcBLsUln7NAxy6cg
         aQrsuBLJUtjYd4G61zWdMzP4RU5nWYQ1pURkPWMSjMbM8XzhcEGpNp8jbldoPKBUj9gX
         XMxA==
X-Forwarded-Encrypted: i=1; AJvYcCXgqtpWVq6dCCSmZ3xdsMQ34KhonxKX9y2UL/d9XTO2JYLPRJk10IWMZP/iiOyiLUTxgUVT6qWVWjZEhok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqs64O6SrfOVisthFMBDbLbCtNnzawj/hVnmVpYNG4e5w9s19g
	b0oTs0rKdluaoT0EdiVHVdUMEapgf4KWpPnkRd77BZcXhUiwSkJUg3SjjbFHyhGQsBel3JC4Geb
	uXly+4Pl+EfL4nc5wH2TxZcTWGBDU2RQ=
X-Gm-Gg: ASbGncvAVv5tqOXgyqOnSwXwVRWfZRpeL8RlHrIo8UMNmXy3zQeAk8QexEtOlV+JtB0
	WUHxuDNrs3Bj1CGNKKLdWkHek0Xh41KqgCz0HNaw82l9bGU2eo3jYkj0a0oNRRVFJoyeOX4MzUE
	gOFrxgDxCU6nzZMLsTL6GMq+mImkw/nv8pMwvKabhnSKT7bHblAaOLcMlVx6GTUnurp3qaOcnGs
	YTBWcuvx12PCC2ORRvvVjj5szLGAA45HP8C9Q8EtU84onU7myCALbj2jajDJ88YB496+We06KTR
	qHC1v3XLrD7Qc0qIWQvB538gcpQe
X-Google-Smtp-Source: AGHT+IGLFt1YCHWbNyJyaEpr+22LPb9d3Q1kWYq7cFolvy1jDcRdvp0v3rx52ay4vxC3D1vRjgD3rmqs6Qx2J3gTPG4=
X-Received: by 2002:a05:6000:26d2:b0:429:8a81:3f4d with SMTP id
 ffacd0b85a97d-4299075ca93mr3213632f8f.63.1761338643874; Fri, 24 Oct 2025
 13:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-11-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-11-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 13:43:52 -0700
X-Gm-Features: AWmQ_bnqGo3VhvdnD4VDhLrtr6dWJQ16k-K7Ue44kfB0ODJ6fAEdUY4Nt58fKuE
Message-ID: <CAADnVQKBPF8g3JgbCrcGFx35Bujmta2vnJGM9pgpcLq1-wqLHg@mail.gmail.com>
Subject: Re: [PATCH RFC 11/19] slab: remove SLUB_CPU_PARTIAL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
>  static bool has_pcs_used(int cpu, struct kmem_cache *s)
> @@ -5599,21 +5429,18 @@ static void __slab_free(struct kmem_cache *s, str=
uct slab *slab,
>                 new.inuse -=3D cnt;
>                 if ((!new.inuse || !prior) && !was_frozen) {
>                         /* Needs to be taken off a list */
> -                       if (!kmem_cache_has_cpu_partial(s) || prior) {

I'm struggling to convince myself that it's correct.
Losing '|| prior' means that we will be grabbing
this "speculative" spin_lock much more often.
While before the change we need spin_lock only when
slab was partially empty
(assuming cpu_partial was on for caches where performance matters).

Also what about later check:
if (prior && !on_node_partial) {
       spin_unlock_irqrestore(&n->list_lock, flags);
       return;
}
and
if (unlikely(!prior)) {
                add_partial(n, slab, DEACTIVATE_TO_TAIL);

Say, new.inuse =3D=3D 0 then 'n' will be set,
do we lose the slab?
Because before the change it would be added to put_cpu_partial() ?

but... since AI didn't find any bugs here, I must be wrong :)

