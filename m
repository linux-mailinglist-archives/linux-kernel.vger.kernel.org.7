Return-Path: <linux-kernel+bounces-754543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C5DB196BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 00:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A772B173B10
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 22:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAB01FDE39;
	Sun,  3 Aug 2025 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V9ey3758"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E941CF96
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754260134; cv=none; b=edQ114jcvZqMvsUx9/Q5m3cLwz1XIc+JXJvR+LBYqPB918IBoREvqa6WwHYH16U3PkTBfiah+UvroupfEHCsUZqMhSv9Ygq1n3/b8zRS5dMRISjDzYG0nb8ob1mVYbZ2NWMReVD4Ob52vsUDdBMhuFEpnapTe6XfJsWT01Acsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754260134; c=relaxed/simple;
	bh=j72ahz5Ukk+P+DMeBtdAmv+ALDkguRExsKqA04HyIT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJc0MOpo0Sd6fQISRneV0jDu+k9k9Z2vXyJ0zlUIyw8Xk0/tyPfeVyNrwmCgDmoaeYmz63kIB9OtD2skuCiRdwalpACf89TpXF3gKa3tcqUDKT0dnmh4MetWhKqVlSrciVYS5vQTv09PWUUlbkxVnmy0EJEMv1Z9idPTZoay/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V9ey3758; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so6601787a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754260130; x=1754864930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9nMa3CbDMyz9QtG00WKPGMELDQvpo2ABLpA9JrL650=;
        b=V9ey3758OlPVq1/iQIn0UccfOGsC8yj11PHK873X0swmkgHQvLu+hffhoWio3dEeG4
         rQFyTDmmolIvdZKvqVkvdHCDlOeGXrmdeporhlZ6tjlWPn0xYu8TAFFIp9hEdMmV/WO3
         6ULc1PGeFLEe9ieDtP1m5H00DBKy/JtGUFZxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754260130; x=1754864930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9nMa3CbDMyz9QtG00WKPGMELDQvpo2ABLpA9JrL650=;
        b=njh96c8/4orVnmKd4m304YwkTyZeUNLsyWaau0BCs4dtVxiotO39/b0wLPPN/AOdN7
         CbVsh497xOBxkU+q+GF2slyI5hJOmgLo89LxKadp58hHOg7FkPk+KnscDlN0+rf3x1/u
         E5itPL8Xk37bKL6D+trEoWI/9fNvSUdME2QbtV3z+2mqQUeHQwEw+1roYbKfYbUDiEIU
         0FSQA8Fcgtyn3yV8g+bGYHh5R9tud7Om5xTXQpusLTTTKXMzQ7Qmvi6EPs30E1b4EgjW
         oyw4/RpOzhVtmY6EbSDNPe91e0DJ4GRCWWcwyPNej3Opi88JA3PuXD3yGsTgs+stw0y+
         csBQ==
X-Gm-Message-State: AOJu0YwbVBDJOKTw71zn2itAdMJ/pKdeASpaSM6LRxS8YrFbxgLF3yn4
	nBOXZ3r14AWXI1gpp4S/RPCjTrBCBpLQMiRlUu6QkYbsFDA1y5SYWBcmNPRONYhmfsKRSrM96oI
	GelRxOYc=
X-Gm-Gg: ASbGncuNe1/dq6JT0UJF9UtxO4Dme9w3WG22dPZAJktRBxVyXr4BO4rIgeCT/gj76RV
	0v+9d9REaF8jLMWCGW/Qv/hX8Hacdd3mxjR3v5eb1eDVosqygsu2S/iyG2zIfwEhwh34Peyrqdl
	U+QwIBSBpO9QKM0mP3F1YSDItiKM4Ak+vz+b0V/EvcjLeKk/3wO+lokKPDv8HPhys/36szNZV9i
	FbCBrCrXUGz8PyplHl5Be4DGxDfFrIyE64s+go/IN/JUtuzlZVN7ild/1XlxjA9XNUhFvGCFVmq
	KEtRFd2LpySw/HlOtLs5wheHo/thelWUcB6NdihB9G93s/VrZFMZzQPT+LL1d3z1pLK9WMlJopF
	jH1A0VfOP6bdqeG6rTJ3DAoD6FxZy1n6ppSwJY/E8vu807FBu36fRXfRMjFslikeceXMlwAgY
X-Google-Smtp-Source: AGHT+IFYvJotGZJ1h4bOTZKjtITkGaUTdJCWA986Gy/ArTzAqKDu3SG8/OZCAq3F8XOjn/mN/27UGA==
X-Received: by 2002:a05:6402:5190:b0:612:b742:5bba with SMTP id 4fb4d7f45d1cf-615e6eec12dmr6119797a12.13.1754260130284;
        Sun, 03 Aug 2025 15:28:50 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a243633sm629824766b.130.2025.08.03.15.28.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 15:28:49 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso5690253a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 15:28:49 -0700 (PDT)
X-Received: by 2002:a05:6402:510b:b0:608:6501:6a1f with SMTP id
 4fb4d7f45d1cf-615e6eb5b94mr6126844a12.1.1754260129102; Sun, 03 Aug 2025
 15:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803095511.6b59d10b@gandalf.local.home>
In-Reply-To: <20250803095511.6b59d10b@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Aug 2025 15:28:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnnEmiaUjc8nQse4rANDcFBKEWcqbwroe+fHBEGjjncQ@mail.gmail.com>
X-Gm-Features: Ac12FXwzwUKGXIzQfCV0UjG0RU22FAvV7Q7-5lNh4x5s8qfr4_tAiXb4PuWYDOo
Message-ID: <CAHk-=wgnnEmiaUjc8nQse4rANDcFBKEWcqbwroe+fHBEGjjncQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Cleanups for v6.17
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Aug 2025 at 06:54, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>      There's several arguments that are "unsigned long" and
>   even "unsigned int" that are either and address or a mask. It is easier to
>   understand if they were printed using hexadecimal instead of decimal.

I suspect you are basically being influenced by seeing *existing* odd
cases, and you'll find that a lot of people use 'unsigned int' for
plain integers where decimal representation makes sense - but because
those printed out naturally before, you didn't react to them.

Doing a quick grep shows that it's generally almost a tie between
"print as hex" vs "print as decimal".

Yes, %x being more common, but not *that* much more common:

  $ git grep '".*%[0-9lz]*u.*"' | wc -l
  45910
  $ git grep '".*%[0-9lz]*x.*"' | wc -l
  62072

so at least there it's a 57% / 43% split, not really dominated by one
case over the other.

(Obviously that might trigger non-print formats, I'm not claiming
scientific rigor here. Also, ).

I suspect you'll now find cases where the new format is much less
legible than the old decimal one.

You might get better results by actually looking at the values.

           Linus

