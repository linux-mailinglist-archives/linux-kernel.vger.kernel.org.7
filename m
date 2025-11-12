Return-Path: <linux-kernel+bounces-897487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B1FC5301C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC82505A21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82949345741;
	Wed, 12 Nov 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imeLv9Ad"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F043451B4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959367; cv=none; b=kziAId4ZwkM6rDcnYgRF3IkLHjvruEznJPV2pgqeGCxKWh51xazMucPZPUtrRr+3YNKjCqk6sg+bgzGheXIoIdvRggT2w/1heNeLeCJyCi/nkl6AIC2wElgPIjr2WOkMztrOdXxrKwxX4Mig2aqKtxGPTybVH28gUaUGUTRZzh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959367; c=relaxed/simple;
	bh=hFHbE+e2+rqcptscvi53POsdj3oRwme2/t5EaZUq1E0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smb/d8QDNiFPNTgnvaU1TK59FjAtUHaJfYFH2jZBUv9FHzMupt+wcWmfArcFcdr5g0Vmw0+1GyyTLP/ciE5745RxUFNGk6RjLCKupOT7+tMBRq8+bg6WyIPWzQevNcmN2mXzsiXmtyBLyEZtAZfZLjH71pBTtF3uNvdcJfikEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imeLv9Ad; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762959365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MHgkPgcHPX1dFyUxLTbk1czGgEYnwCygEJaWcsX1mJg=;
	b=imeLv9Ada4RXRM0jEvrzCRNzgJNTnrjGOiiYZDmZiXGcdKvA5HcmhxC9B3CcF9aJdrwsxW
	MRe1LmSyhm/rxAa5rpqb052dFABOyRdpKXOa+uE45xjgcHqFGWKGKAXMgnyt483VeFTq+D
	qTCUEI57iqecwj477oNCauPsJNWO1n0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-p3t-qYRxPlCzWGBkEOIRCA-1; Wed,
 12 Nov 2025 09:56:03 -0500
X-MC-Unique: p3t-qYRxPlCzWGBkEOIRCA-1
X-Mimecast-MFC-AGG-ID: p3t-qYRxPlCzWGBkEOIRCA_1762959362
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D08AB19773CA;
	Wed, 12 Nov 2025 14:56:01 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E3F1196FC8B;
	Wed, 12 Nov 2025 14:55:58 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  linux-kernel@vger.kernel.org,  dev@openvswitch.org,  Eelco Chaudron
 <echaudro@redhat.com>,  Willy Tarreau <w@1wt.eu>,  LePremierHomme
 <kwqcheii@proton.me>,  Junvy Yang <zhuque@tencent.com>
Subject: Re: [PATCH net] net: openvswitch: remove never-working support for
 setting nsh fields
In-Reply-To: <20251112112246.95064-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Wed, 12 Nov 2025 12:14:03 +0100")
References: <20251112112246.95064-1-i.maximets@ovn.org>
Date: Wed, 12 Nov 2025 09:55:57 -0500
Message-ID: <f7ty0obfgg2.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Ilya Maximets <i.maximets@ovn.org> writes:

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
> ---

Thanks, this makes sense to me.  As you noted, the "fix" (I don't really
know if it is the right word since the functionality never worked) is
quite complex, and still might not be 'good enough' to not have further
issues.  It makes more sense not to try and support something that never
worked to begin with - especially since even in the userspace side we
never really did a set(nsh()) thing (because it doesn't exist as
functionality).

Reviewed-by: Aaron Conole <aconole@redhat.com>


