Return-Path: <linux-kernel+bounces-883818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 413F3C2E803
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2ABD534C319
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E222D515;
	Tue,  4 Nov 2025 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd1daP3U"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB42FFDC9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214404; cv=none; b=iWY3z1wn7jiRfWbhBVh50XLOjZWoM+JmagMSSQck/VEdRQFWMO2oYs8HhWSv6u++gHl9XjdPOlNF2KjTMbdMU0qYOuhmQBQgik7+Qw9KWLdODz9dJTByAPJm1b8WwwvgCPkjqXATD/6MF8QLx2nSbvlECBryw0e/awD212ZeWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214404; c=relaxed/simple;
	bh=KWPNuUAA+ZhQ/+txjpPIM4bu1Y0YAxVagodXMSfYadM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2NL1tsrzXOJVsnwjMMwvmGkS6/wBStbGZ+mbiSA/2XnKsGGSeAyseosJ4smhNLr0L5d0pfBBbYSqAmiRe7dmTk5YjmiZBGON9zMvfgsPO4avM6aBBj5VSPdBv05ZRWtmi3eehhvghrUozawEpf8N0cJS5vXzXcwKAeZinfg01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd1daP3U; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a271fc7e6bso829464b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 16:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762214402; x=1762819202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4GA6qXjepP74GDLbPqnV/zm1OBuSXWJ1hYuYBFhr4k=;
        b=gd1daP3U3+g4oQu8PR785iIZdfOkVoMU7LIaQVNCOFBoz9Kd3HikBlC3pVL9BkGOUD
         m1j/y4CqWqUxHswW7td6ajnUXHTLjMGI9/j+52fRWAE9qxcBT8TgKTsFtzefYrjvs/lr
         MNL5yOYgX00LstJi+M78t29hiY/z9GnXd7iW5p2t1NV8ic5+G22B9wCtv+hVbfzn20xj
         LNYKUYe9AvazetvQy8oyx9mCK5m9sh1tnWCMZfzDmztHji/vIWuBb+52kkfIkPLqzugR
         I0W8OzOM5Ld7Qrsixa2OUhJVEAUfVJW1EYSknH4/MwD2C1W0xMHf5SPpgWl0Gybp1BPc
         2A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762214402; x=1762819202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4GA6qXjepP74GDLbPqnV/zm1OBuSXWJ1hYuYBFhr4k=;
        b=B0GmTjKT4PZSjVkW7/9TT2+hz5GvNgdPo3zbzpRGsHHZdrq5yoJqiYB05fp90X8S9W
         36UsgA14uceJ1qvWOM7pXfm1A8e+6eHiB4pIJV2AWUP9WHf5TAnwed8bcehbm0kU21y+
         FPcVBmmP/WMSjWi91lXQnhYcV2A5m2ERAysk+HVhIGK0evuGGODNsMCTb/vaeTIFFTKH
         gQem28HMUe3mwzeqwWJlNHbB70ksRTPRutQA5cDcrjWkE6iZMsmCQ7Sq8guZf9PrxH5G
         1S4RHoQsVbmlcOVIhZHIMVRS5fGEKHnAG+Hpy+rHvtQDs3NeGU9b9InGbyK2y8U9pRq4
         5nyw==
X-Forwarded-Encrypted: i=1; AJvYcCV7HTGUXzowKX0foZ3Ln2Xx2V8t7fK4yzh9YfdvnJPztTWb51jTHB5SejEvSoPfum1AHCJUiQo7mUeXg+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YysNbluQ5go0fMHcdsWKge58KXnEc0F0DSpBNJoRCU3c7JKNuE9
	8zXzVVwCRPpz4IxPZl4qnSQCuGMbHUzrCfnom+ff+gtxzYTNuQ5Kcx655NorHAV15iWKy0Umb5f
	nmt9qNNOZcx+oHwL2so0u7cxZairZyVQ=
X-Gm-Gg: ASbGnct85fVoy2przYhjFGcNHz2DNfqRy8Rq/KEius2iEwIKFS6SaBHj6TywZ0j+zBB
	7OGYUNTBRMVqddjzW3/AZotc3q+SRk3gPikeaLgVpNHTeehRcVb1H7gbSgtiA75tk+29MbJV+uj
	e/oCFCgF59FZkz0Ji6VhZxHQaC7afJjchy5CIzPQe3zbRE2aQZoeDHGq7m6pSwrrggB/2lGvdUT
	SAbswpwzLIe1PfuIFPQjJtkUOirq03je0CpzSOy8NAM7xCZ3IqrJ+Ugq/IicRM+UHzgTOPxBqfj
	6ZZvt0NoihzTjhni1oWHf556ZkKbURLjRsGe+Q8w2VGQj/sygM1vRHOi8KEIgZ5RdV5HUhtjCOD
	JkwqLRrYiXDyXCg==
X-Google-Smtp-Source: AGHT+IFf7MsVxgzAaLMfrcAu9oP1ypCD1l5vYGKVDQF+ssx3KpBLarOL2v3Sp6TMg4K3L7H41F9nuwSgrOl5zJxS610=
X-Received: by 2002:a17:902:ce8b:b0:295:304d:41e8 with SMTP id
 d9443c01a7336-295304d4876mr88981055ad.6.1762214402530; Mon, 03 Nov 2025
 16:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104105516.40fea116@canb.auug.org.au>
In-Reply-To: <20251104105516.40fea116@canb.auug.org.au>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Nov 2025 00:59:50 +0100
X-Gm-Features: AWmQ_bkGRFs_UNGZ5EtKszuymNzT7RTMbJB-EoXQOOisJ_XgxgKjCesre1kTg2k
Message-ID: <CANiq72kP0YMCEMjEVdTfVt4eokbXm6iRAk2PxmFZybNgJaFzGA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the modules tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 12:55=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Today's linux-next merge of the rust tree got a conflict in:
>
>   rust/kernel/str.rs
>
> between commit:
>
>   51d9ee90ea90 ("rust: str: add radix prefixed integer parsing functions"=
)
>
> from the modules tree and commit:
>
>   3b83f5d5e78a ("rust: replace `CStr` with `core::ffi::CStr`")
>
> from the rust tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This

Looks good, thanks!

Cheers,
Miguel

