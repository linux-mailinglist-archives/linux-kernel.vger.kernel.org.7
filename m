Return-Path: <linux-kernel+bounces-894195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D8EC4973C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 032114EB14B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F5A2FF642;
	Mon, 10 Nov 2025 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELZ14Cfj"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBE2F39BF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811382; cv=none; b=M6g2xGIMKGggqyZZbsRNvuFY6Wj+37olHKi36lxA53IY7W7l36YlSd1p1VKusDs4gV/XzNRAZaMPPFyjg6TFxy8C1J4GwQdXGQpHfS71V9ZDhcBBmnIZ1JsD6/zjZup4NDCsfhBIV0cQIatzHPJsdjCbGsKnIUBPGlVi4NvcGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811382; c=relaxed/simple;
	bh=yVjviV3zopbG1PAfCWMvFshBkzHtOiy9INXF/AyrOjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuOC9sdbddQ4ElksEfm+84uUXBz5Z1UNc81us7Mgv6ak29VvCMB/01Iui0Hq5roJzf+1URvNeHdRJ656Gov6TOyLhP8pk1Xl9dVZw+4p3o5wLWObHCEKChiIZ07SfR80KC3fJ4f1rnSi2wczV8+9m9EutwPt8KZns5irzcTeEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELZ14Cfj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5942ee7bc9dso3404318e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762811379; x=1763416179; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFirqqcYt6xjzQLvnHeiyd54+NIBXchkEuHWoh2vuEE=;
        b=ELZ14Cfj9MG5Ek0/l9eeH/fIFQMGqh8G3P0o3tQcIOR2AY++gN9NOsFux0xdVdkO0v
         MU2OKQdYIen9yRt5rLjN6bvyQOaJQ8UYJaZWXxsmd6LkU3JEWUAbF9ulY+Zwn++dGE9t
         ThLPbe0s+JrPqiiKcJrsag1c3Uw0jRG8pHydamyIP3g58KmXkCqczTED6EJUFDfOE78H
         +RaawlpsDr25t6K4jglBizAPhm0jL9Z8kxp+O9aP6T+vVY4U6J5InZS8V4pqXniQPZBQ
         2xEcJg8SRJPckCf4vj3My5MAmjC2Gk8IYc4bFJiYyWie7GmF22LJuqJAaezdigqj25vH
         uW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811379; x=1763416179;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RFirqqcYt6xjzQLvnHeiyd54+NIBXchkEuHWoh2vuEE=;
        b=ozaWhRg3PZ/eedBUeFj4IUAQ1HYNsKzZpwG4iDqqAgoYH1iowWjOP9p4F0HsczoNcU
         OV3n+J1YkVUJU6n6EWuMrjqH+8Nsr6nRkyaTjAvpQdFxSsPz+/JvvmHAvuqON19ZmPPe
         k4JKEYjU0GKaONI49EQTJVeR8UTJZ07SEfAOTrLu2mQwY2pATCP2rpbB8iyfP3nuK6BY
         ekcmP07s43qdUxdSQ4dum786oSSWFQbOAdaAcAgNlgruu9CypL2qyYQBNhqOx0921cds
         bPbjHGFpeot0a6taSnIZvndXlJRVa1V43NdTVznPzW0rsXB+VUgfXSUnBHovfUxDoe81
         Ximg==
X-Forwarded-Encrypted: i=1; AJvYcCWWmy4xsbzFoyD+vhvLwTl/h/3SZdUOhEbZd4rMJDSMo9dCFTI+HQ1uNITu5y7KfPrilixEoRCFqXCQCho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx472U8laJiroAUuxkgKiQPZ+sueC590e2c/DSjNCJglxtKNSi5
	TnyDMiSTR0ylRri2BwKHAIjPk9Nb01E9P0FuknH12nTlanO0X4NThy7t
X-Gm-Gg: ASbGnctuYLs+WRJx46NJxsO+ySnBU78l8eopYgzmvdI8KvExNZ3t/VdinAx9X/oSsTi
	Qj16L9RBq0h4TQfwVK4cNEo4eFj95CkMwPmfmNUKVvAhZvCmvMnJcPCo/ZjMS6XuHjoDoMIha+O
	s/zufFQtAkOkSR2/7cO7+Nuro0c+Ap66Xg/K0Jql+mpoG1NsXxWoMTNznh2mrF0/4BIjycHG+h1
	VG084bkPlZekdGVMYHumBVCwQWOMETrLXXMkUxvSli5u2z27gbRauREzC+PMVbU2Td+tsalce+b
	wPzqwccroY+rw/wdenU3qey19OdGhlZmPNrhGeNsXnYZ9sJ+RzJNDNk78npgXAxDXMq/H/0/RfN
	tiWAQw4hC4s4/QtHa7+sDrdBwK+bZ0OZ1c2DrPAQDbaqYMrw537ffgcv8venmopjoECwsyF0LpQ
	gVVQ==
X-Google-Smtp-Source: AGHT+IGjkYEZuiIm45qpRwthPMBOYrneNAO2t8mNMUlpQZhecV1r6b86jhyyoGDLr3xqW66ODHKdcw==
X-Received: by 2002:a05:6512:3a86:b0:57c:2474:371f with SMTP id 2adb3069b0e04-5945f1e5562mr3111337e87.45.1762811378727;
        Mon, 10 Nov 2025 13:49:38 -0800 (PST)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944ff427d0sm4115144e87.68.2025.11.10.13.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:49:38 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 93D625A0033; Tue, 11 Nov 2025 00:49:37 +0300 (MSK)
Date: Tue, 11 Nov 2025 00:49:37 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] exec: don't wait for zombie threads with
 cred_guard_mutex held
Message-ID: <aRJd8Z-DrYrjRt4r@grain>
References: <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRDL3HOB21pMVMWC@redhat.com>
 <aRDMNWx-69fL_gf-@redhat.com>
 <aRHFSrTxYSOkFic7@grain>
 <aRIAEYH2iLLN-Fjg@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRIAEYH2iLLN-Fjg@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Mon, Nov 10, 2025 at 04:09:05PM +0100, Oleg Nesterov wrote:
...
> > > 	if (!((sig->flags & SIGNAL_GROUP_EXIT) || sig->group_exec_task)) {
> > > 		sig->group_exec_task = tsk;
> > > 		sig->notify_count = -zap_other_threads(tsk);
> >
> > Hi Oleg! I somehow manage to miss a moment -- why negative result here?
> 
> You know, initially I wrote
> 
> 		sig->notify_count = 0 - zap_other_threads(tsk);
> 
> to make it clear that this is not a typo ;)

Aha! Thanks a huge for explanation :)

> 
> This is for exit_notify() which does
> 
> 	/* mt-exec, de_thread() -> wait_for_notify_count() */
> 	if (tsk->signal->notify_count < 0 && !++tsk->signal->notify_count)
> 		wake_up_process(tsk->signal->group_exec_task);
> 
> Then setup_new_exec() sets notify_count > 0 for __exit_signal() which does
> 
> 	/* mt-exec, setup_new_exec() -> wait_for_notify_count() */
> 	if (sig->notify_count > 0 && !--sig->notify_count)
> 		wake_up_process(sig->group_exec_task);
> 
> Yes this needs more comments and (with or without this patch) cleanups.
> Note that exit_notify() and __exit_signal() already (before this patch)
> use ->notify_count almost the same way, just exit_notify() assumes that
> notify_count < 0 means the !thread_group_leader() case in de_thread().

Yeah, just realized. It's been a long time since I looked into this signals
and tasks related code so to be honest don't think I would be helpful here)
Anyway while looking into patch I got wonder why

+static int wait_for_notify_count(struct task_struct *tsk)
+{
+	for (;;) {
+			return -EINTR;
+		set_current_state(TASK_KILLABLE);
+		if (!tsk->signal->notify_count)
+			break;

We have no any barrier here in fetching @notify_count? I mean updating
this value is done under locks (spin or read/write) in turn condition
test is a raw one. Not a big deal since set_current_state() and schedule()
are buffer flushers by themselves and after all not immediate update of
notify_count simply force us to yield one more schedule() call but I've
been a bit confused that we don't use some read_once here or something.
Another (more likely) that I've just said something stupid)

+		schedule();
 	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}

	Cyrill

