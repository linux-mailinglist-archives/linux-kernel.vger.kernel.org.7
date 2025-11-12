Return-Path: <linux-kernel+bounces-897281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DC8C5282C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E8C3BF54C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0875338F20;
	Wed, 12 Nov 2025 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEXok792";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nV/Y79Tz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A9337BAE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954145; cv=none; b=EThkhEY1WD4C1yPLFBxiIr40iaSI1GGVSJeuBtQSoFCNU1TJxPXYz8f0sd8zyfqAIQYJSTvXXdcoGpSR2QEL7m469piguxVsC5kwowMuSmVzjB1dUmP5dvYOPBRQ5GL+aTcdOrm70xQrzaFGaum8tSJAxJo+FbXBq8bu/VaiumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954145; c=relaxed/simple;
	bh=2hiXwZOx9q/AQWzpz41tgoiVkCduyG6fAWQFbExNFcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDPVxEvdiiqzREFdrcMOU5zuB7voGPkqk3ev6bpL1saTNwpJFWa3PxpYHLzr0gw8waPLzcUe5pAyxE/FlkIFdOw2jyFSxF/TjYugiwgc0uSHxMGahkfBfk9Vm9C4U1QX75t8uhHm1m5QA7E495OsdqNFBCiwbtANdRI+fxIb3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEXok792; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nV/Y79Tz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762954143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrKEYgoIA+04HmwcyGlHc2lcud53I+xZFpr5fUVn1yg=;
	b=HEXok792UsAk3So/WtDRZLYhz36k6Ax10vpK3b+5YWpfuQUU4gvpap5h+SJX2fltKWzO1V
	i9ITKhxDY9n/scOL/WJO1z/Q5hBeoQJ2HDyErvo9NblbDgsA3qcOGKfkb1sNe4Jnuqub8I
	9vHqG99kp92+lC85yYlgRwa+eQJqQ1M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-5Ex71B4AM2WyV5Jr8Uh-0Q-1; Wed, 12 Nov 2025 08:29:01 -0500
X-MC-Unique: 5Ex71B4AM2WyV5Jr8Uh-0Q-1
X-Mimecast-MFC-AGG-ID: 5Ex71B4AM2WyV5Jr8Uh-0Q_1762954141
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b72a8546d73so132666666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762954141; x=1763558941; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrKEYgoIA+04HmwcyGlHc2lcud53I+xZFpr5fUVn1yg=;
        b=nV/Y79TzxDyJ3I6SbRFD/rFREBYS1Rz3AmHDkYXObiKnwREq53Pe7xoOfAmEBu1ojq
         ytpp11kRhjwcQ0UOHJboqYb99o6dvpq3DjCsO9wg+g8fRDpgmnQd/ErJfQtaadzAN3Yw
         g58M4OThtmP+ZeT8+kduW/wW+kbaWstNFD/6bz4LI3GOMVtE6D2b9SNF0DGSSuear/EG
         cO72EtJcWr0MkAQ5EPytOvp9dnCc/UsUID4urf1zVDCsuhkPMgctV9mJS+y0jPb5b8Uu
         8EIbBRyHXtBs/IcjncRq5MibVyoTQ0xp7CmCzfcGOgAe7uSqul+kcTS5bQ4rW5k4N3v/
         Jl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762954141; x=1763558941;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrKEYgoIA+04HmwcyGlHc2lcud53I+xZFpr5fUVn1yg=;
        b=ilT7pkQh+wqhawmBj59O28B3N/sjNVwiVqX3bVXFFIEF4nhql8pu3g7oZA/Uclt+Cr
         RBztrp18xBkcdwY15XzS+K67THAhiqtsG0+YAS25GSac7LmnO20xyMjLWQsBjsUj70eZ
         n3OzfvSCE+lU07Ho+f4sV9cHPU4iqRuRZzxGfWr8plUMHIH73zibcQq3NNEX39E/kqpa
         x+eFz1DERe2u9Eped7GxN94wLq6GDi1dtH3kK3lFXLm7ONL5n54TbdtU1h7ZPfLdUQG2
         4SlpPPmeMWU+TiLWM6ms2qsAx1pIL5bjBGyPwJGDTKDoZ2tVExWJlmS8CG1vtdQm2P1z
         bPDg==
X-Forwarded-Encrypted: i=1; AJvYcCVcI/w0IiRlrOM3ZSBFdYoaghAINCtlg6j4rkRvXELDBKdwClNpvQY8fvwtyhY9kKm3Xx74zDg8OkOJ9Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcPU7CGiv8wDrOlVqf1kc5dyLoC0gbjDaZN6al1rRTZ+tinavd
	SDkw0EDagVLnQKHXff4nb17TNYJ+2t2p+fNLHV/Ax1rwTBkobeo+529GjbJCnTzANFKByv0oapt
	t1e0/Mnsusn6GAZwiskRFp9ycRFy0+VVInytzeWFtn8I7J/doMSxscC9nkXRerAFPMQ==
X-Gm-Gg: ASbGncsNYrJIqC2968BvznxFNP8oHRck/jhNLdHzZX1NW+l0cTa/NvzQKvk+XXn+Tz3
	iNccmGLEXBX7qrLMhOGMkE2ZfGWF8TIAtJ/odmpFBRSzQelBNcTnBvHAcSBpFurk1BwIgi277Jk
	i584Ug1xbtPBWJhSs29cFRRNSderrCBW2tAUcd1DUoCS3BBjjs5i0Xp50OrCfteVTYQirzTvfgb
	IABbI7dHwoE1FQYFLEQ948UMDcslQpoykADVwbYKWyLC+2q1JD7l0/KTglnnx3WCHtBIVYHPw7e
	gIjF6VwSTg1zCHYKEGQaEE0/hbz0mpD+0PCJOQIBYHs70CAShrqHFpIG/odTs3zPkmAtGyxYHN2
	Kx8CEuAp3fLn34W1gU7mN0Hx69JNwXTZTjJTZeD6xo0WBwxqSYKJtSJDl/k1s6wm97Iww5pOoPs
	B4B/ZQBIYL35DkQxMavd8jfQ193xqR+I7+Egw=
X-Received: by 2002:a17:906:6a1b:b0:b72:dbf2:afb8 with SMTP id a640c23a62f3a-b7331b3a223mr266282066b.65.1762954140616;
        Wed, 12 Nov 2025 05:29:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+yX1s77nIKTurGOrwJJg1rBXxjO/ilJ/UOB7GklIbKi9xnjuh020vX/d/xVMJoB8aTAx3PQ==
X-Received: by 2002:a17:906:6a1b:b0:b72:dbf2:afb8 with SMTP id a640c23a62f3a-b7331b3a223mr266277866b.65.1762954140119;
        Wed, 12 Nov 2025 05:29:00 -0800 (PST)
Received: from [10.45.224.224] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bcd59sm1580794366b.53.2025.11.12.05.28.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Nov 2025 05:28:59 -0800 (PST)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, dev@openvswitch.org,
 Aaron Conole <aconole@redhat.com>, Willy Tarreau <w@1wt.eu>,
 LePremierHomme <kwqcheii@proton.me>, Junvy Yang <zhuque@tencent.com>
Subject: Re: [PATCH net] net: openvswitch: remove never-working support for
 setting nsh fields
Date: Wed, 12 Nov 2025 14:28:58 +0100
X-Mailer: MailMate (2.0r6290)
Message-ID: <E12AC26C-AB1F-489C-9BC0-A35593FD03D5@redhat.com>
In-Reply-To: <20251112112246.95064-1-i.maximets@ovn.org>
References: <20251112112246.95064-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 12 Nov 2025, at 12:14, Ilya Maximets wrote:

> The validation of the set(nsh(...)) action is completely wrong.
> It runs through the nsh_key_put_from_nlattr() function that is the
> same function that validates NSH keys for the flow match and the
> push_nsh() action.  However, the set(nsh(...)) has a very different
> memory layout.  Nested attributes in there are doubled in size in
> case of the masked set().  That makes proper validation impossible.
>
> There is also confusion in the code between the 'masked' flag, that
> says that the nested attributes are doubled in size containing both
> the value and the mask, and the 'is_mask' that says that the value
> we're parsing is the mask.  This is causing kernel crash on trying to
> write into mask part of the match with SW_FLOW_KEY_PUT() during
> validation, while validate_nsh() doesn't allocate any memory for it:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000018
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 1c2383067 P4D 1c2383067 PUD 20b703067 PMD 0
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   CPU: 8 UID: 0 Kdump: loaded Not tainted 6.17.0-rc4+ #107 PREEMPT(voluntary)
>   RIP: 0010:nsh_key_put_from_nlattr+0x19d/0x610 [openvswitch]
>   Call Trace:
>    <TASK>
>    validate_nsh+0x60/0x90 [openvswitch]
>    validate_set.constprop.0+0x270/0x3c0 [openvswitch]
>    __ovs_nla_copy_actions+0x477/0x860 [openvswitch]
>    ovs_nla_copy_actions+0x8d/0x100 [openvswitch]
>    ovs_packet_cmd_execute+0x1cc/0x310 [openvswitch]
>    genl_family_rcv_msg_doit+0xdb/0x130
>    genl_family_rcv_msg+0x14b/0x220
>    genl_rcv_msg+0x47/0xa0
>    netlink_rcv_skb+0x53/0x100
>    genl_rcv+0x24/0x40
>    netlink_unicast+0x280/0x3b0
>    netlink_sendmsg+0x1f7/0x430
>    ____sys_sendmsg+0x36b/0x3a0
>    ___sys_sendmsg+0x87/0xd0
>    __sys_sendmsg+0x6d/0xd0
>    do_syscall_64+0x7b/0x2c0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> The third issue with this process is that while trying to convert
> the non-masked set into masked one, validate_set() copies and doubles
> the size of the OVS_KEY_ATTR_NSH as if it didn't have any nested
> attributes.  It should be copying each nested attribute and doubling
> them in size independently.  And the process must be properly reversed
> during the conversion back from masked to a non-masked variant during
> the flow dump.
>
> In the end, the only two outcomes of trying to use this action are
> either validation failure or a kernel crash.  And if somehow someone
> manages to install a flow with such an action, it will most definitely
> not do what it is supposed to, since all the keys and the masks are
> mixed up.
>
> Fixing all the issues is a complex task as it requires re-writing
> most of the validation code.
>
> Given that and the fact that this functionality never worked since
> introduction, let's just remove it altogether.  It's better to
> re-introduce it later with a proper implementation instead of trying
> to fix it in stable releases.
>
> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> Reported-by: Junvy Yang <zhuque@tencent.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Hi Ilya, thanks for taking the time to look into this issue.

Acked-by: Eelco Chaudron <echaudro@redhat.com>


