Return-Path: <linux-kernel+bounces-856764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CBBBE4FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D2B1A63F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDD922D4C3;
	Thu, 16 Oct 2025 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+kSMksD"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DB2264CA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638119; cv=none; b=D5p4sdNKzTBi6NHDPkDXEQOKnfyPiOY4t9pIqVBssaq80SEvPVywESzWXX88vIkDhpmadqvesYLfTD6qAZB1hbnDaKQlpXceI21dNRmxKkHX8g10LJc7+RMjtxegPXepxObWAU8qBkUiCOYqGZSOiUxAYMI32ojByxkD4oZ1SWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638119; c=relaxed/simple;
	bh=pvdI1tHJ0y9UyYUK8ggKpv8HiCk5nY9MZSyFsaBNsRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvvtoNgO9b+bY1sBMVfllTzJnWlrXkqC7X/xbPiXdz0E3KomCno3ReWpnWpRvIUqlwz0KXbLV6kNvNDSwwaqgiUQn1fX9Xkq+Py7POS4829WyjmpED6kxxgBM4o1+ml7dxsAxeAAUDouVpLQbIHvsRUX+rQI7WL6SMc2sI1VOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+kSMksD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26e81c17d60so2003905ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760638117; x=1761242917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvdI1tHJ0y9UyYUK8ggKpv8HiCk5nY9MZSyFsaBNsRY=;
        b=H+kSMksDV6T3s5wcA+ctD5yFuJ3P2xIRjT8GofqOvekOwjggObbh1tjNFvvAbmbysQ
         drrQWQOeYsWB0QP4G84ElM5cb6IpCHTFsPZf/FmtyGFwboBVhk6K9LEYTYf36Aia+qfF
         KdfmUmlUy5HzI6alFFTkRL6+iz+SVYmWneHDGIHsoHj4q3dMgLHejT0a0RJC9kM7jGNk
         zDuqSWLOkMmQWmRUXD4XyjnmttRUw8/nua74fIdgS3dxmlDQinTMRFJIyOP7l0kRsVhv
         LjL9A/5NAVT42ncBZ1EPKGNt/BBQjy7xaOk89rA+x6V2AQRelOg+10GWOfGJAjniS6JM
         i4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760638117; x=1761242917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvdI1tHJ0y9UyYUK8ggKpv8HiCk5nY9MZSyFsaBNsRY=;
        b=QJafMlW2zvutsG3g61ZYJrCeQlB3EVuDa3jBvIT/DgvE0Z0AudBkJuOw2MdrSS6GdF
         bcIeLConbZHxfFlb7a/dnokGuTI8GV7UZP2bAQILuiLH4ZsbYF4bRvQpqG+TM7yC0efi
         sGhwGKPUNhHKsOnZRYFsA0LO6eqeK+5ihKleOfxraam8VmmYv8dG+EKggcm6FQCUg7bL
         NgPAT6rOM2D6Lc5YNysEpO6FAIFAamGcIMmb+WrZjEz6LgmUSmxRtlEYMPdpAG5vhrJG
         9N+l7pasia7QQjbSnBYadHrAWYMKV/joAcfMzxIgm5WmnXG7h+E6aG/R4UVHbX2kUgLf
         RoNg==
X-Forwarded-Encrypted: i=1; AJvYcCWSblCzSaDpXiw04jqGtgaAEjLag0x39SIDEGBLj0QQEL9x7noM6wh/NuPzXdJVP74ZG6ivHK9U05fzFeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSannUpNtX7OH/mfcUkYR3tJ+NAH2UzcSaO0Uw3vv2LRmTgw57
	U2qBqKAFjSJHW9fGczDfaqX/AvgFLRVfXv8ZCms6N//4MBOVVdqKAURHhWejWh5K1TJZsJloEWm
	QoVXGXVOhtJKlZfDWywub4L2/jzBB69w=
X-Gm-Gg: ASbGncvFU665t/mFN7gekWGH2t6c0G7/uh/t8Sz91HOE6NL27UJhlUsJlYlkQc5t2Kw
	L32D7NydippscQX+YdT2NwNY5f0yhOLnCuY7azi6qn83gtpgwtK7UBvzQSUYeljKJutdZsAglAA
	g8E1FQYAKF+taLLntm3dITQLwW6SMpp7sF14oiIZgBOUVgjWfi69m0iCn+4bkZNsC/ezLxuaO/x
	PScx6ahkis5+XMU9pMzgdTNr1sbe5702p9eMRkDK/42hGoobkqTWzh3MwXyZ/0wIiK6nrxiHYjD
	h7nRGccj9CjJH2m35z8IvBk3t2hCww6D44xqzEnMJgdMV6xqsvrk/LCKcQW8sh3PuIfxU62r8x7
	wmPGm0PWw6y348A==
X-Google-Smtp-Source: AGHT+IEoB07YLtvOmgRhJpNg1dneDk3OqPXrwHl8ZjlPvoUL+f8vvKYxA5NW6SB6Z+zvhdKoNNyC5a3rT2Kl6EmYok0=
X-Received: by 2002:a17:902:e743:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-290cb27ec63mr5305925ad.6.1760638117403; Thu, 16 Oct 2025
 11:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016172853.52451-1-seanjc@google.com>
In-Reply-To: <20251016172853.52451-1-seanjc@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Oct 2025 20:08:25 +0200
X-Gm-Features: AS18NWA8avJ7AT3gN1GiIIdaHzAYbZXDs9-XkxbnI3nrmWWVp79jjOsrQv3WW6I
Message-ID: <CANiq72ntKAeXRT_fEGJteUfuQuNUSjobmJCbQOuJWAcNFb1+9w@mail.gmail.com>
Subject: Re: [PATCH v13 00/12] KVM: guest_memfd: Add NUMA mempolicy support
To: Sean Christopherson <seanjc@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Shivank Garg <shivankg@amd.com>, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 7:30=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Miguel, you got pulled in due to a one-line change to add a new iterator
> macros in .clang-format.

Thanks!

The macro is not in `include/`, right? That means that, currently,
when I rerun the command to update the list it will go away.

If that is correct, and you want to have it in the list, then we
should add e.g. `virt/` there or similar, or we could have a few
separate lines at the top that are independent of the ones generated
by the command.

Cheers,
Miguel

