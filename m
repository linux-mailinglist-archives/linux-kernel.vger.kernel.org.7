Return-Path: <linux-kernel+bounces-819852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8947BB7CD3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0945D522A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E80721C194;
	Wed, 17 Sep 2025 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qe+wNvvg"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C61A9F86
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072835; cv=none; b=giT6P7znZu6dIL8A39qSofGqcdCNNmjxJvu/6M3S7m8b7ukG3psBiCrouxYnAPRfmq1DroIoVMQCakhTCMNGsJCjlH88gxKZE2vuVlI30TMywLH49ah0oXC7gCsXpoHQmk1N3bD/fwfeG1dx/G7/JWrc+hfX3FTt5cSritbE2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072835; c=relaxed/simple;
	bh=0heUhGb7g54M8ozu1OASeuvS0XjRgdig+E1hh5iT4sY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YHZ/fxkW2vgSNYEkhkypmeO6w2EfckyKdDYK4tNz1rsCG6wg251FjxKauvuhChLEKCdh0yhIbBdfI74WaHNqjD9Da0BYJEwfQWd2e4tufg0C8rmjnuD+k0vBBBk52bSNB7aNNxZDSF6bhZwZmnexvdYhazmJ0RudNuyTeE7Wt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qe+wNvvg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457f59889so63150355ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758072834; x=1758677634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXpZpJMeVhGYO9gIBZ2NZsGYecTrOOiKqT7H+6noy3Y=;
        b=Qe+wNvvggsZZTW+ApbqFkhyGIDoKsJbRBKMPBclAM8lUB3EVbPFcifIwnE0803ava9
         fMIlcvwe7/iy3nxyPsXsu9sx0MNCkDEKUsgeq3dIWgAp5/yYSEy2mbSxH5XbkZrYVOpE
         DVE62EgxkeDDnjFQDg3nnoM5EmFiGg4i9YGKuEp/SSGSALLtliIjGB0R1QoPjL5M9Dhx
         uhhRD6K02WPHIEcHB2u4bdwES6mn1XOY6cjNC+UM3iwoefGFPzdSd1zxKF7pChg7zw/Z
         1hEj1lvhOSnB/XHnVdKZ2YtR/A3K2ZgkSw6vmZM2sgP/u1D7RQ19Sb4RTbY8k7vZzi7k
         1dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758072834; x=1758677634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXpZpJMeVhGYO9gIBZ2NZsGYecTrOOiKqT7H+6noy3Y=;
        b=IJ63Jx1CbK+yxi1d3cHS3yb/Yditgu2bwBmcD4sOYjXqAeq5RwcU9j4o3/qYuZ4CYz
         ETVto/09od68vmHVAcUitSa4DB1HAuS/aIQyTYiwtfRQVXKJBHTj/HnvcEkFAx84Fb3s
         QJ740AAmGvqtxqzggN9CN8fbKQWyjns7UQBRhEA7au9bRqBrWGDTE+5NCPgGvE2eb3Kz
         hu6y1JlatMLqc+tthRLQFF3zNRleUZqHMqqXLFqyX4d/9EjgcNlqGExfKSCQu2WDwd/F
         3JJzyVls5iuRY2tGA+cCLYdCQc8AV9QIOUmGGYwVbllSvEsnejB2CvInykORnsMkQdr0
         7wbA==
X-Forwarded-Encrypted: i=1; AJvYcCX0Heg0B3kgxJEBIY0ZK9Ko5HKww1vBejE3/HE/snF5J8N3uNecYj1kAC0MbY8ry3LY/11pr+/ZXgx5Zlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYu6hkO0gGInXISZjNBTl/oWSFcbvPItUAV2PJ2bdo/VCJJqg0
	Thv/uEvZ+az1+MawCZzcom6gZElMoOzRp/whjHbC/GBgenDuqDNaUvGN0+D6F5jJYRCdGikL6OJ
	hwlp/Bg==
X-Google-Smtp-Source: AGHT+IEMVleSkK89gkmfEHssr+X+W6hD8LJmFm5iv+hvPkzIpLwz9m1GYDcafkkn4/PO2fHFkjoJDXasCUI=
X-Received: from plbix5.prod.google.com ([2002:a17:902:f805:b0:249:3ba9:c64])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e888:b0:234:9656:7db9
 with SMTP id d9443c01a7336-268136f9e3emr3836345ad.32.1758072833656; Tue, 16
 Sep 2025 18:33:53 -0700 (PDT)
Date: Wed, 17 Sep 2025 01:33:33 +0000
In-Reply-To: <c36676c1640cefad7f8066a98be9b9e99d233bef.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <c36676c1640cefad7f8066a98be9b9e99d233bef.camel@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917013352.722151-1-kuniyu@google.com>
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
Date: Tue, 16 Sep 2025 17:16:40 -0500
> > Thanks for the report.
> > 
> > Could you test the diff below ?
> > 
> > look like some programs start listen()ing before setting
> > SO_PASSCRED or SO_PASSPIDFD and there's a small race window.
> > 
> > ---8<---
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index fd6b5e17f6c4..87439d7f965d 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1971,7 +1971,8 @@ static void unix_maybe_add_creds(struct sk_buff
> > *skb, const struct sock *sk,
> >  	if (UNIXCB(skb).pid)
> >  		return;
> >  
> > -	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
> > +	if (unix_may_passcred(sk) || unix_may_passcred(other) ||
> > +	    !other->sk_socket) {
> >  		UNIXCB(skb).pid = get_pid(task_tgid(current));
> >  		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
> >  	}
> > ---8<---
> Just came across this when troubleshooting a resume from suspend issue
> where I'm get a black screen after suspend. Initially saw this with my
> distribution's(Linux 6.16.7-2-cachyos) kernel, and confirmed the issue
> in the latest version of the vanilla mainline kernel. Bisection is also
> pointing to commit 3f84d577b79d2fce8221244f2509734940609ca6.
> 
> This patch appears to be already applied in the mainline kernel, so
> this might be something different. I'm new to mailing lists, so wasn't
> sure if I should report this issue here or start a new email chain.

Could you test it with this diff and see if 2 or 3 splats are logged
in dmesg ?  and in that case, please share the stack traces.

I expect this won't trigger the black screen and you can check dmesg
after resume.

Thanks!

---8<---
diff --git a/include/net/sock.h b/include/net/sock.h
index fb13322a11fc..211084602e01 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -539,7 +539,9 @@ struct sock {
 				sk_scm_security : 1,
 				sk_scm_pidfd : 1,
 				sk_scm_rights : 1,
-				sk_scm_unused : 4;
+				sk_scm_embryo_cred: 1,
+				sk_scm_parent_cred: 1,
+				sk_scm_unused : 2;
 		};
 	};
 	u8			sk_clockid;
diff --git a/net/core/scm.c b/net/core/scm.c
index 072d5742440a..e603bf5400e0 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -510,7 +510,7 @@ static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
 		return false;
 	}
 
-	if (sk->sk_scm_credentials) {
+	if (sk->sk_scm_credentials || sk->sk_scm_parent_cred) {
 		struct user_namespace *current_ns = current_user_ns();
 		struct ucred ucreds = {
 			.pid = scm->creds.pid,
@@ -518,6 +518,11 @@ static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
 			.gid = from_kgid_munged(current_ns, scm->creds.gid),
 		};
 
+		WARN_ON_ONCE(!sk->sk_scm_credentials && sk->sk_scm_parent_cred &&
+			     sk->sk_scm_embryo_cred);
+		WARN_ON_ONCE(!sk->sk_scm_credentials && sk->sk_scm_parent_cred &&
+			     !sk->sk_scm_embryo_cred);
+
 		put_cmsg(msg, SOL_SOCKET, SCM_CREDENTIALS, sizeof(ucreds), &ucreds);
 	}
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 158bddd23134..ff68b8f7c119 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1545,6 +1545,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PASSCRED:
+		WARN_ON_ONCE(sk_is_unix(sk) && sk->sk_state == TCP_LISTEN &&
+			     skb_queue_len_lockless(&sk->sk_receive_queue));
+
 		if (sk_may_scm_recv(sk))
 			sk->sk_scm_credentials = valbool;
 		else
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6d7c110814ff..c8ea44f6d1d7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1897,6 +1897,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 	unix_state_lock(tsk);
 	unix_update_edges(unix_sk(tsk));
 	newsock->state = SS_CONNECTED;
+	tsk->sk_scm_parent_cred = sk->sk_scm_credentials;
 	sock_graft(tsk, newsock);
 	unix_state_unlock(tsk);
 	return 0;
@@ -2037,7 +2038,7 @@ static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
  * Return: On success zero, on error a negative error code is returned.
  */
 static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
-				const struct sock *other)
+				struct sock *other)
 {
 	if (UNIXCB(skb).pid)
 		return 0;
@@ -2047,6 +2048,9 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 		struct pid *pid;
 		int err;
 
+		if (!other->sk_socket)
+			other->sk_scm_embryo_cred = true;
+
 		pid = task_tgid(current);
 		err = pidfs_register_pid(pid);
 		if (unlikely(err))
---8<---

