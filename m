Return-Path: <linux-kernel+bounces-821485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B08B81610
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E874686E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8319303A29;
	Wed, 17 Sep 2025 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGYvRdc+"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF33009EE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134591; cv=none; b=UJfZqjnbslxqTP+wAWmccZZcOGRtrPOYWZHTRL66HrRyQ/dcI1Z6CSenHNfG3Dq+a3AoThfy4l7L5u0f0G1SUZ/xLY+svvez6ZXDgNVFrGk0GgXOnxoAAmmIBhmcXOzre4t9rYJhHi98BSGU39VpUcHpoBBwHbsUVGSMVB0YGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134591; c=relaxed/simple;
	bh=CO4Z2qhPiwjLUf9m3lqbizWU30ePe61aVaBOg25eiMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HPUpQMkbpnrfjsganqmFI+hc7GTtkYgwGsUPX8N5LbZ5SsBrmpy+y7M8FLTS9XvX4cARAtEpDUp5sUpBnTUiD75cbKCJuviFqs/7QZL+a+XCwgpy9D0VmVqHyafWTawXp0S33WYP7FkcCJnTU2g/v+UmFzVkJx+ZbieK3EjU88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGYvRdc+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so60444a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758134588; x=1758739388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnn/1bPiYFjxxZYlOzXb5RYuvwtgWrVEsfiGmhllIQo=;
        b=sGYvRdc+YWl84CmgSZrFAC3hS4eT0Hty11FN90X+i3gwgs50vKoUjw5yzIQt2XEp8M
         eZ/PCl/LC/0L4P5jFiD4DzXs6pIvDb9i7yrqLTCqyhUO3TzFhUTZIgBqUQwlqYsn23Z8
         eIXrFm3CuILGZW1gEDte9DGdq+wPYz4L8o3pfgTkUZpWT+4p4FLngM34P/FIS2vF1QQg
         ZhE2TZ4XvZTDA7i5V5tmjb4mScsB4SIplKw3+EhURzQOLniiPK57TGqmjJGvcE1xYwdU
         Sc4SHbQvq48cJ1/4GXWRQh2Xzr/gRNsn2/oyMT7Lza4Qk5Yr7cc6hi/qJ8y4XHcCv0oR
         uG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758134588; x=1758739388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnn/1bPiYFjxxZYlOzXb5RYuvwtgWrVEsfiGmhllIQo=;
        b=wXZ6jjyVvZ2cKtOzQ3XMf6Mp+H+DAzYuBn2DPF6w3GR/J3btI/13UtLHFj7GiQ4IaR
         IolFyZrIRPLwrR7Du1DYT3+BOkkW2Rqs3H8MB1kyFN+3GqklCebscw6RRyk81luNp4aO
         m9a4yTeiMhf9aO3pxaibfw8zVEvCq0ZHxxjXbWerXl/DGl8RYSDJTceygWN+QBRxo7jo
         CNU7KycHkEtlOSAdTjrBWkC5zWrIfQrDaRKSN5FxKcwN8QIJi3sGSTbhBmr7spR0j10Z
         siMioyNNKwSnOHtU9A6Paduxd2WxlRsXnBY2uIMTff+ZxOm2s5jlyltpiZcxOl850Byy
         A0jg==
X-Forwarded-Encrypted: i=1; AJvYcCUhFBgVEzQqg8dwemQEDAz7QJG3mjP9YfDzOlVOOotTH7AjvWBOcjPoiIMwlO4P2qujbpSqa57cZHT7Auc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB9//2OFiUS5GHqzuC6X5zGFwJX3gJXF523DJqR6+RdzS7mOkb
	DK/Ck+t1MmcklSLtBzv98k14gnGO1A7SYw0nN7joSLo+0cVHk16/CJNw8TFTNqGUIiPTaWvAHB+
	QEcBVvg==
X-Google-Smtp-Source: AGHT+IEhGNWjJW1GJ5MpbhHOgHkB45XQY9aZPy3HjmU7BORBjFIa87Gpe9fvclpNk85p/3LCUAJSkOe2WNw=
X-Received: from pjbpb7.prod.google.com ([2002:a17:90b:3c07:b0:32e:8c6a:e6fd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3902:b0:32d:ea1c:a4e5
 with SMTP id 98e67ed59e1d1-32ee3eee5a0mr3788820a91.1.1758134588448; Wed, 17
 Sep 2025 11:43:08 -0700 (PDT)
Date: Wed, 17 Sep 2025 18:42:58 +0000
In-Reply-To: <d994dd8855c3977190b23acbe643c536deb3af71.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <d994dd8855c3977190b23acbe643c536deb3af71.camel@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917184307.999737-1-kuniyu@google.com>
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
From: Kuniyuki Iwashima <kuniyu@google.com>
To: brian.scott.sampson@gmail.com
Cc: christian@heusel.eu, davem@davemloft.net, difrost.kernel@gmail.com, 
	dnaim@cachyos.org, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	mario.limonciello@amd.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: brian.scott.sampson@gmail.com
Date: Wed, 17 Sep 2025 09:40:22 -0500
> > Could you test it with this diff and see if 2 or 3 splats are logged
> > in dmesg ?  and in that case, please share the stack traces.
> > 
> > I expect this won't trigger the black screen and you can check dmesg
> > after resume.
> > 
> > Thanks!
> > 
> > 
> Good morning/afternoon. Applied this patch to the latest mainline, but
> still see the black screen upon trying to resume after suspend. The
> keyboard looks to be unresponsive, as trying to switch to a tty
> terminal or back doesn't result in anything happening(as well as
> numlock/caps not being responsive either). I also tried using the power
> button, as well as closing/reopening the laptop lid to see if I could
> trigger resume. 
> 
> Checked the systemd journal just in case, but no splats or anything
> else is recorded after the suspend. Finally, attempted following dmesg
> with -Wh to a text file before suspending, but that also doesn't record
> any new input after the suspend.

Thanks for testing the painful scenario.

Could you apply this on top of the previous diff and give it
another shot ?

I think the application hit a race similar to one in 43fb2b30eea7.

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6d7c110814ff..b6ff7ad0443a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -815,7 +815,8 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 
 static bool unix_may_passcred(const struct sock *sk)
 {
-	return sk->sk_scm_credentials || sk->sk_scm_pidfd;
+	WARN_ON_ONCE(!sk->sk_scm_credentials && sk->sk_scm_parent_cred);
+	return sk->sk_scm_credentials || sk->sk_scm_pidfd || sk->sk_scm_parent_cred;
 }
 
 static int unix_listen(struct socket *sock, int backlog)
---8<---

