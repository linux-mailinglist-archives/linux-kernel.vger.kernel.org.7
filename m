Return-Path: <linux-kernel+bounces-752266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61FAB17352
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3B7A819C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736819DF5F;
	Thu, 31 Jul 2025 14:39:42 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73F639
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972782; cv=none; b=nfcX1BUoZda4XojcNDKh7BdupAAX6EvkLcMU48/kOYsdTkoblLbGcy0aWdFHotH92/kte0fx7mTsqoyTA6VDECG9NTZL8CcOQhjgXX9XWhPBbTrKiAyLSHxHriAm9qxnGomLTCogX0/o4trMA13Pnw6lK5xWvm6Az4NbAtrQvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972782; c=relaxed/simple;
	bh=uzaY3Vx47rrOwvJ4lSuXaPdxgQnAmhgALt1ufbXX6EY=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=s5iUBt2/xFDdNNh1nOQ4nhO8s5ap9AtO31ayMtFmELZqMlGaBeXcaRAyMrIDRDQ9RKaIeKkogxG4B645feEmwTKTNSJK6x3OWlhr12jkLQeuhXfekTfoo6kasm2ZbZ7YkYB0rfge2cs5x47mPm7DIMCUuW/c8vsw4V97iwIMqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4btBYL2Lp7z5B13W;
	Thu, 31 Jul 2025 22:39:18 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 56VEdA1v036401;
	Thu, 31 Jul 2025 22:39:11 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 31 Jul 2025 22:39:14 +0800 (CST)
Date: Thu, 31 Jul 2025 22:39:14 +0800 (CST)
X-Zmail-TransId: 2af9688b8012ffffffffbd1-6ee7e
X-Mailer: Zmail v1.0
Message-ID: <20250731223914188BCyA6ps7dI6ffNSFD1K-V@zte.com.cn>
In-Reply-To: <20250730150240.GB5339@redhat.com>
References: 20250729152759994n3YKgjxLglCCPkOtYtU2U@zte.com.cn,20250730150240.GB5339@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <oleg@redhat.com>
Cc: <tglx@linutronix.de>, <frederic@kernel.org>, <peterz@infradead.org>,
        <brauner@kernel.org>, <iro@zeniv.linux.org.uk>,
        <joel.granados@kernel.org>, <lorenzo.stoakes@oracle.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IHYyXSBzaWduYWw6IGNsYXJpZnkgX19zZW5kX3NpZ25hbF9sb2NrZWQgY29tbWVudCBpbiBkb19ub3RpZnlfcGFyZW50?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56VEdA1v036401
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 31 Jul 2025 22:39:18 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 688B8016.000/4btBYL2Lp7z5B13W

> > -    * Send with __send_signal as si_pid and si_uid are in the
> > -    * parent's namespaces.
> > +    * Use __send_signal_locked() instead of send_signal_locked()
> > +    * because si_pid and si_uid are already in the parent's
> > +    * namespace. send_signal_locked() would incorrectly modify
> > +    * them when crossing PID/user namespaces.
> >      */
> 
> Well, Thomas doesn't like the idea to kill this comment, I won't argue.
> 
> However, this comment still looks confusing to me, and I don't know how to
> make it more clear. Yes, send_signal_locked() may, say, clear info->si_pid
> but not "because si_pid and si_uid are already in the parent's namespace".
> 
> There are several obvious reasons not to use send_signal_locked():
> 
>       1. do_notify_parent() has already correctly filled si_pid/si_uid,
>          the "has_si_pid_and_uid()" checks in send_signal_locked() are
>          pointless.
> 
>          That is why I think this comment should simply die.
> 
>       2. send_signal_locked() assumes that different namespaces mean
>          "From an ancestor namespace", but in this case the child can
>          send a signal to the parent namespace while "from parent ns"
>          is not possible.
> 
>       3. send_signal_locked() assumes that "current" is a) the sender
>          and b) alive task. Both assumptions may be wrong if "current"
>          is the last exiting thread which calls do_notify_parent() from
>          release_task().
> 
>          In this case task_pid_nr_ns(current, task_active_pid_ns(parent))
>          will return 0 because current->thread_pid is already NULL, and
>          send_signal_locked() will misinterpret this as "from parent ns"
>          and clear si_pid.
> 
>          But imo, it is simply unsafe to use send_signal_locked() in this
>          case, even if currently nothing "really bad" can happen.
> 
> OTOH. This patch doesn't make the comment more confusing, plus it removes
> the reference to __send_signal() which no longer exists, so let me ack
> this patch and forget this surprisingly long discussion ;)
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>

Hi Oleg,

Thank you sincerely for your thorough review. I truly appreciate you taking
the time to share your valuable insights on this subtle but important issue.

You raise an excellent point - while the original comment highlighted 'parent's
namespaces' as the key concern , your analysis reveals more fundamental
challenges at play: redundant validation, namespace direction mismatches,
and the inherent unreliability of 'current' references.

If we keep the comment, would this version work better?

        /*
         * Use __send_signal_locked() instead of send_signal_locked() because:
         * a) "current" may be zombie/unrelated (sender context invalid)
         * b) si_pid/si_uid are parent-namespace ready
         * c) child→parent direction breaks send_signal_locked()'s assumptions
         */

I'm happy to follow your preference here — please let me know if you'd
prefer to keep this.

Thanks again for your guidance.

Best regards,
Fan Yu

