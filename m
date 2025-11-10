Return-Path: <linux-kernel+bounces-892907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8B3C4615A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A4D1890D01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530123074A7;
	Mon, 10 Nov 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTcqSOx7"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4A3305E27
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772303; cv=none; b=FPbBJ4TF1t0V9jc7U0UxjCA20b8k5DL6nmJjZXRBQAu70RFOiCGpIQtLg7sxScGDOT9vXPM2rC4QnTICYujp+cKqZQnICfPb3K/kRtH6nLOv9XrbxW0AOXuPB72zg7QIICexFkNcc/OKshA0X9H7DvMQTiHaui6+99YKjAHR7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772303; c=relaxed/simple;
	bh=2U4KaUAelMziEmY2ShfzM/dox45MOEZL+6xWWn9Wxas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVP/pTwZpUHlaks5InS/vl6BO82eWMldepd5hawzuyHfvO6yxBP0rNOzoh/JuK53EglAiRgkGIoyDO8TIYte83yH9rf0lHLj5jEpBE/y8DL2nzNXV/xSKcA+VBKP9HPD13JQUp8pzkEp2ybJzYVCnqsRb7KxbZ4F112dPEm3KEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTcqSOx7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36bf096b092so22626241fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762772300; x=1763377100; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cQtUBYgJJUDzd/kGspKY/MZmhkbZxSeoEQPwDEqgRs=;
        b=NTcqSOx7ig9H2EIc158DWbLgS07sNYRKpJfCyIdI4ilhKtbi3USxe7AusiqhwLy/lz
         s9IoLfSktAalSXpMeDil/3umKjgSx13p66KaU6kMidfBkpF0Tpdy6Q3WN5/H0ZWcqBpj
         eV7okqZsfqxG3qI5031IOur+LbphMQzKbw3I4SwwT8rPmMdWiu5yxZxmbM2RtZ24ljY6
         pLerxSAmTuKINtn8SY7iOWpOFoABU8ZJs4FPJL8xE/fS1kj5UWZjHdqZmj4tMotWe/5T
         PM3FzRxkGiHp1ucmmNV7VoJ+OqqFZ48eFc7c+ZYzM5T95gJdzL779itiMaCqaMlnVu+5
         BW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772300; x=1763377100;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5cQtUBYgJJUDzd/kGspKY/MZmhkbZxSeoEQPwDEqgRs=;
        b=Ze1Fjs39bcNbg6PaPJHONjVKVq2/Hi2R+gailPzazDrVmCyMkWtQSXg8M8bLQSld0R
         rmh04aEgOBZ79oyZDFTJkrsyjUGjVApSrPmdvktvEbtZGaBeXU1mn9fMCQM4wv37XPSi
         ysyVj7u7rw86KI2F5IpDjzNcQjtSIxjitzmF4RxMiSHKhDhmx3/aBJHEiR7TqGxt3Thw
         lx4E6et6r9z3BJ5AXwQtWZzOAKSD0gxVOum7T9pBsIhXBh16wjtcMJq3DtTDFvyOi3s0
         ksyDHua7tPBjj/bIMIGCfvUDraoEk7dXonLPbBCGCYMLs+qkYhcPtgSThFwiFeGjGUwK
         71ag==
X-Forwarded-Encrypted: i=1; AJvYcCWvm803WCOIN5xsxzdM7RUpdL13Fy7pR5w9BjKvtuoHFnhslGFP224Q02bjhmO9Hplw5Fib+Yh+WsFpH/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNeMXg4eBTgupXYIXKEd7gO7dcMYiFN9BJQ+lFep4rLCOX1fRT
	a50QB9GT/W3ksMmjtdjZm9rR3PwQJLMZ9V/UUFrfKRppXmJdg7SSwK4Q
X-Gm-Gg: ASbGnctzyCDtfBZl1yvM5ncqt0byd3RF6O84BY162CsByc3n4KrmgtDrjoWpxJeDv+1
	0p2mjVmTFkUAgwoqp/1qAG0AeUy35d+nztcFmUFpaPj+yDmJpkiIohEresZfmYp0PoJCKxG3sG0
	ld/cbkwM6bSN5RF80ASBL+YP2bJ0SGiCjP41dmLTgmjIyHaOjlPlkexzLuyJAlNVESgeq2yT1Jk
	1MoM4l4i4+SO+M0QcDytu+260cFe5Dstv/Lh3ei9nTIdeEEHTIWX2b0GDvai/ZTTcmEXIdqBEfe
	FPED/nRuSCdFqaLniveChr8RB4s0gszlBfHknJQQL3/H157WZtSXSkI5KE+C/GCkTA+UmtPP/s0
	BQp0fQ0BiD4I5PvCF4cc8VNrJqjuZCVtzvaC2yIpgRFyIKsJuFoMlUvxs6lxA10PuASiwqvuVgR
	csZgwyEHLEeVWY
X-Google-Smtp-Source: AGHT+IF7uc05YKR1RuoI0CoWlX07D9z81TzLgbg2o88xiS2GWX+oFbp3ZEM1dvWDPFPIbk1p56pL9Q==
X-Received: by 2002:a2e:7206:0:b0:378:df5b:fbac with SMTP id 38308e7fff4ca-37a7b30c374mr15069891fa.38.1762772299942;
        Mon, 10 Nov 2025 02:58:19 -0800 (PST)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0ee40csm34451431fa.43.2025.11.10.02.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:58:19 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 691DA5A0033; Mon, 10 Nov 2025 13:58:18 +0300 (MSK)
Date: Mon, 10 Nov 2025 13:58:18 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] exec: don't wait for zombie threads with
 cred_guard_mutex held
Message-ID: <aRHFSrTxYSOkFic7@grain>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRDL3HOB21pMVMWC@redhat.com>
 <aRDMNWx-69fL_gf-@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRDMNWx-69fL_gf-@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Sun, Nov 09, 2025 at 06:15:33PM +0100, Oleg Nesterov wrote:
..
> static int kill_sub_threads(struct task_struct *tsk)
> {
>  	struct signal_struct *sig = tsk->signal;
> 	int err = -EINTR;
> 
> 	read_lock(&tasklist_lock);
> 	spin_lock_irq(&tsk->sighand->siglock);
> 	if (!((sig->flags & SIGNAL_GROUP_EXIT) || sig->group_exec_task)) {
> 		sig->group_exec_task = tsk;
> 		sig->notify_count = -zap_other_threads(tsk);

Hi Oleg! I somehow manage to miss a moment -- why negative result here?

> 		err = 0;
> 	}
> 	spin_unlock_irq(&tsk->sighand->siglock);
> 	read_unlock(&tasklist_lock);
> 
> 	return err;
> }

p.s. i've dropped long CC but left ML intact)

	Cyrill

