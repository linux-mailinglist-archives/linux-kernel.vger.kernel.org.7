Return-Path: <linux-kernel+bounces-830244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A54DB992E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CDF1B226D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F612D949E;
	Wed, 24 Sep 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOUeeZW7"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA32D0C68
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706625; cv=none; b=uNpGJr7KiGyW/LtkQaceFQvFjoP0O8h3roULqVOR/Lvt27qkrlhKuj67AphH8+y93aCS/odw25j5tFERPxCYbEriAeqIUtvmhshrISrzU0/+zMCNDuHWfDVX3AIWo5QxE/hVcEQ0Jw6E4ssXt0RoeRMA6DOCa7yEmgklCqeZmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706625; c=relaxed/simple;
	bh=tHDZPTjqsvGSVtD2vzi+B0EfyL6Wl8yhlQVaMzP6+5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fG+Otcd/1i6D1i1dscchO3Dl3EFJXR0EpXz+4mEHPIGdvQug7LUc68tkNrwHZeavNJglf9yU4PDMgfNfwacaWBbU9evPxQv+YTOS29pdvteO9svypQVGrd/d64B2Q/MXlF3uYL3d/KslJV2RrteAF8tHf7VSqSJN7Pzzzr/zSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOUeeZW7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-36639c30bb7so43371991fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758706619; x=1759311419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfQjDW9lOZhqCcu0UR8GmRDS7/f9HDxq+dUiuWeXOX8=;
        b=dOUeeZW7JrZiu+ESKbVavy5wTYbdqQl9588/A6PDdjGhRUsmYzMq61bYJUeh5529gB
         SbqVQa+Z2mV0OSNb7Yk9t7dCunhR/+iO+DLQ+Dog5L96DfmySOQbJkKNzljeDuNLasyx
         ISET203X4CWrHT1+VK6RJsd09aJxps1M4teHSZFioQnPGmidNZ+mdIfBATyFKQEZzOnu
         gMfXR/sMao54f0BqIRAlSj0RO/n9GZnN4dL7XPEtfUOrcyAnhA6eGRUUX7LuKaGu2WiP
         aTB0o0QkononnFBw85tNHSiBn+OEuimDokMWeFs3Znr2XPY+dkSB+1U2risufOjne62U
         N6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758706619; x=1759311419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfQjDW9lOZhqCcu0UR8GmRDS7/f9HDxq+dUiuWeXOX8=;
        b=O4HOz6I1RtAYR+o9zHAwgjKdYKwe9HxnxC3Tzp4Kunricobx0nOdL97nkOTQ9jMvDv
         oaCV2R/OkY4E0ltdBVODPkh1F2YuYrjZS23RnO+0Obwvb7Fsci6iEJuZzGjXwH5sjBm1
         i+syjmPtZAiuF//Cihi3pCJtn3HvZcPInFhSWhtCWaq96yo/yZZymugOTIipalbkSGdH
         rNxakVqgNU/+0Gx4NzRrnLHsuIuVY8HpP9AEhkW6gdSpLNYjZcnCB8ZeWgySgkAG/41X
         zAhtkr+6eKlaPxHxDJFFBjnJ5Fg6mOixkg7YjmPSl0doUc2kpxUCgxkurFFd1KTebK5Q
         51fg==
X-Forwarded-Encrypted: i=1; AJvYcCXzoK4UK3gisF7ZSyiR9mN3b0pYCDlzsndG3oz2QwmtResosGYD7vRf5WiFPbSIo1fcBgMBgOaeVgJosVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80dQQIg+rtXEaXJAoRTUVq+ErheMmYTc68pu41KR0I2yQsus+
	0WZ4qbec0dzgwFkTrepaP/f2odJWFHcqHTwx9h5xfcCeaPQQPp9jv421
X-Gm-Gg: ASbGnct6pGFWeN0QpktJT6orTz83pDDDNjgAq+Q64A1MqUuJlSvWJpTVq5Anlb6y5s/
	tJ6/RDlAbeUocDQqMVbG650yQJvitI6mz2axTfCXWnx4nBv8YyUKMcRmlRIR6CpQKiHJJ1JYfU7
	pm4mRiOAHiLnoztDIzIXPLZe14g3mvOeQV7H6AMOctHnv5nMLuII3sk8vmRFzoiZDI/SV+EwjeB
	N6eRckmToj83Q0KQ4JEHwxdRjILaTX08JuHuLpcms2q2zUmVGKj1GO9YAuwsH73d0eZfDphj6ht
	BnzzYWZD4Y4A8S5KHE1YTCLk0lSAHi2MSu9IoC/r8aTVos43UABI8gWPDShXFVecg8cPGJl4ZOg
	FoBfFIAweWo2rY6gwBFYcb0yV1ewTjzZWfSU=
X-Google-Smtp-Source: AGHT+IGAXIFBfltfcFUi2JvMXFLpdNu20IBm9lusClOWXvJ5IvB5Xvu2p2lzfwLhA2Gs0+4M6+OmAw==
X-Received: by 2002:a2e:b8d2:0:b0:36a:f4d3:82e9 with SMTP id 38308e7fff4ca-36d14ebb0b5mr14965271fa.6.1758706618408;
        Wed, 24 Sep 2025 02:36:58 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a26cbbd6sm43990051fa.23.2025.09.24.02.36.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Sep 2025 02:36:58 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:36:53 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: viswanath <viswanathiyyappan@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
 david.hunter.linux@gmail.com, edumazet@google.com, kuba@kernel.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 petkan@nucleusys.com, skhan@linuxfoundation.org,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250924113653.5dad5e50.michal.pecio@gmail.com>
In-Reply-To: <CAPrAcgMrowvfGeOqdWAo4uCZBdUztFY-WEmpwLyp-QthgYYx7A@mail.gmail.com>
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
	<20250920181852.18164-1-viswanathiyyappan@gmail.com>
	<20250924094741.65e12028.michal.pecio@gmail.com>
	<CAPrAcgMrowvfGeOqdWAo4uCZBdUztFY-WEmpwLyp-QthgYYx7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 13:32:52 +0530, viswanath wrote:
> On Wed, 24 Sept 2025 at 13:17, Michal Pecio <michal.pecio@gmail.com> wrote:
> >
> > It's not freeing which matters but URB completion in the USB subsystem.  
> 
> Does URB completion include both successful and failed completions? I
> decided to go with "free urb" because I wasn't sure of that.

I think yes, usually in USB-speak "completion" is when the URB is
finished for any reason, including error or unlink/cancellation.
"Free" could suggest usb_free_urb().

But I see your point. Maybe "finish execution" is less ambiguous?

> I wasn't sure how to describe the flow of execution in a multi threaded program.
> I will resubmit a v3 with this version of the execution flow

I think it's an irrelevant detail which CPU executed which function.
It could all happen sequentially on a single core and it's still the
same bug.

In fact, I just reproduced it with all CPUs offlined except one.

