Return-Path: <linux-kernel+bounces-823457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A54B86842
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85DB4A66EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2342D8DA6;
	Thu, 18 Sep 2025 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJdUviO4"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBB2D7802
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221295; cv=none; b=Xzx6/H1Gyo55aqrVr7BRbPlqvPej3JuYSe8FSMLI0PD8j+ksvQrat5p0N2YPw5FfAFDEIAcxtlGSDMbnsVl9ueijnZ9vuIMsA30z+4nbkPoJp4TDs3vCw/jPDUEyOSrMx8mPOLXKOF98gmEnE27O92rLi+udgaHHC+LzPflcQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221295; c=relaxed/simple;
	bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGOU8+pf+YrDO4Dzbi6PVnZLsZrGr2hwLGo9DlWqBlw75WjuDP3O8vG7LIaZiw5oXnrnah6I3TZOphCB+JfqLwQ+CJnDzmXIYH8zaFiv6zQoo4xncKVNr1jQS1S+VveKsFJvFJwl63uxU4zLyu2n7pLcwZmqpTgqZj6YdQEyQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJdUviO4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b54a588ad96so975431a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758221292; x=1758826092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
        b=GJdUviO4cMljecghqlZIW7CMeuCDdgmnHnycTIqsUgeS7I4Kurc0uAJznZUMpmaf8x
         I7aOIlZPmm9HPwepR5dookk6dax0vqIjt6Lj19Sw2vJLst00yzF131lUtEh7t/tH5cJA
         R6J2QTA1prI7MVpFSKo/Xn7Io2asQVQBOVFHo5sOX5tFJYyt93j8iopUfKVBf7kbm2L8
         QKjiMJNWae47REPpg7dBpzWqecqEKMAlr4ZHenvdeXWndKxKdosRrgO0hSmvyLUDMrFl
         wCcZuGxwdVWCcRcHgXuI3gKWdTcQuhZ4B/Bn3nCKuaHQgoqlmykgOmMUlsLDzSOdzXDM
         7i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221292; x=1758826092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
        b=h46nbUJuqCQHpYYxAYz4z1Aa8pes9oQAmYEtOudvKcY1oMqhCMedrjBM5/bis5Umbp
         HjdAZ8tBmGkV8ieU8xb4nSzrxYTgYONMdpe7EKz6gLbLWzCEMhK8iJjIlBnt8gGhA83Q
         qhxOpEasaB/g6VdCBJnztF2G0PpMVzEExm5lW/EA/nwpySk8bOwlvtXFZ7agiXOpbli7
         PqAm1j/drjpnmkN08hEyLJQ8fEXhiOpsXyotTPInvDmWZ5BH8GgLqX+Hc+fvtSNxYG7e
         2qZv8fRR4EhoN9eSW/c0piranJ9e19MiY32u3xisiG4jMDN0k7ErdasnFywTqsp9UDBg
         7FGg==
X-Forwarded-Encrypted: i=1; AJvYcCVt4jHHXdkSGSrxyLp69Vv6BZ8+ZJgewUmcuB4wtRce+hl2rPxVZSoslZzQC0cJo1Qdya/ItEHsR1Vjxzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9kuZ/Fwpg4Q1B9hSg+sWTFIB7eHfrI+sTr6s+4AKwnNdwwQI
	FqLCS9lzstAzn31CEztYU/MFDYB+kuCZBRVNYZx3zz2Bn87qcoIVfouaFymbnCOP+kSPRrc1EWV
	KnhQP9hay+8NOwMR1PU7Se2LPmo00ZzG7Paij9B06
X-Gm-Gg: ASbGnctmE6LEJ9M6eFstJR45Lpb/6TFDTYaoIE4F7oRQMOy8GhTDmfiaemO3ti0a25P
	k5BQPvuvvdyUU5rU6OGhGXX+vtmCuB2xmHe4EkNb8BNm9abf3YoPVXid5wA9aVwELfXXAP+lpu8
	8xbZol/C4kbpGp+7kUELsOhrVMU6bovqtyzaGPAhD+lq8Qqkx+fTVEh+d8q1bKhyFmVWYxUBvgV
	oFSvY5A4q+6qN8L/ehDWCkxTTcnspPI0fcvx/2k6BPdsYdCvHR/fiWvTSxW+JBarA==
X-Google-Smtp-Source: AGHT+IFChwu/WXFE/Bk1qPbNxzjVEQRH8mYRXcstr2vxeJXZTN7B4PXslngta4OJd71ruXQZuBfYRAqRPI1cCQdkWpQ=
X-Received: by 2002:a17:902:ce09:b0:267:c1ae:8f04 with SMTP id
 d9443c01a7336-269b92f5037mr8368235ad.20.1758221291602; Thu, 18 Sep 2025
 11:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
In-Reply-To: <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 18 Sep 2025 11:48:00 -0700
X-Gm-Features: AS18NWBIaYnWg5h64UvvqbyXa3vbYuymfJ8c7oW4xcgcAtF9AXx0O8o97REhA6I
Message-ID: <CAAVpQUCy-xurW6r9oUcDV17fS3wiJsn2QuQ1mQ4k2wXYa6L1RQ@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: reset blackhole on success with
 non-loopback ifaces
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:51=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> When a first MPTCP connection gets successfully established after a
> blackhole period, 'active_disable_times' was supposed to be reset when
> this connection was done via any non-loopback interfaces.
>
> Unfortunately, the opposite condition was checked: only reset when the
> connection was established via a loopback interface. Fixing this by
> simply looking at the opposite.
>
> This is similar to what is done with TCP FastOpen, see
> tcp_fastopen_active_disable_ofo_check().
>
> This patch is a follow-up of a previous discussion linked to commit
> 893c49a78d9f ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in
> mptcp_active_enable()."), see [1].
>
> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/4209a283-8822-47bd-95b7-87e96d9b7ea3@kernel=
.org [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Note: sending this fix to net-next, similar to commits 108a86c71c93
> ("mptcp: Call dst_release() in mptcp_active_enable().") and 893c49a78d9f
> ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().")=
.
> Also to avoid conflicts, and because we are close to the merge windows.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks for the followup!

