Return-Path: <linux-kernel+bounces-897943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF43C53F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5CA24F81BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427AF34FF65;
	Wed, 12 Nov 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO5qqAZ2"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46B23EAAA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972198; cv=none; b=oHDfYmycY4QUzEYZCWBW5N4bOJW389NX2srmwffmmcDObaHD8MXSXbImjU/NsNFhpQ6bjMBhO0ghvfIPC4OxI07Ik522DZq2mVR1OFXpUXh0gVKJER4UBqtFDe1L9Zg+hPtqMkz/HgKpr4VBpcZK/fOF1LApLtcHtsJ9tyg03ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972198; c=relaxed/simple;
	bh=m+1Ia7kTgcgwak0tup6RnzackIUD2uj9VJ66wpL5vGU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P88Hs+GPgaFySKfcAk2PfnqAfNPaRAVEmoRaXJBJtNzow5TEdSflIGzKMZeBZzGSQH1o1P4dUYfoq31Ztvvzyx1q7iJ4fCN31cTg9Z4oXXgzyp+9ZJcw1rRPdNQdIT09qmdoe80RKB5tMsxayrcIdgOuXJ9aDUUHN2WPZnY5Nmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO5qqAZ2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297dd95ffe4so10924415ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762972196; x=1763576996; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+1Ia7kTgcgwak0tup6RnzackIUD2uj9VJ66wpL5vGU=;
        b=HO5qqAZ2+Gl5VjkG2JSxHnyizcDJJvWMPSuF1MP/DI6trW1yhrZRkin+PzYaYHUjS2
         RBcDDcacxNXxzTpkQ/9QSU8fDNFrnL3ojfLUMFAHe6rrP5dycCLZCJR2tOaEHv4GroS3
         vk5iiwOrc79Da3t+l4gAEAkQLQwCl4cvMyasv2eAP7TtSuNngSJwsg3EDzbRKarxMB4j
         CMLdpb9tw8Uo08ghQ046tPNG5SYpAxjbAymnPkLiuOTc9QR3XE1IMJrXuLAaui5sHjDB
         pXuJL2WENAvfEN1rNqM8iUhPKOX0ptF3OIQMAGOtcy1ZhDcsox6MwrRyW6w/1JAip8oC
         2Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762972196; x=1763576996;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+1Ia7kTgcgwak0tup6RnzackIUD2uj9VJ66wpL5vGU=;
        b=TOAsWxfLPCejEUoRPN4tk+49k1f3wtrHydwQFeOxj1YjzzFxo6etwVfwZTqTTwccpU
         SdUx13g7f93U7NGoEUH3r4et199sTkh7Gm3HjYpBWSRNwWocLFZsvcBOWXa6meB8BzXs
         i84FryqepgN10EGuAIL3xs8Z9xVlzXu8A7Tj7hxctENm1wt7n8V8CbeDlp2MjLoBW9ZW
         k00gaOc8W4nEK0Sgz4zoiAmKXVZzzinWRCEx0PlNVeEl5NYZNO3Mqvp+bpsu3nVxXGXh
         L/15ez2CKlLNgiWX9uzcRHa1M8k3OgXK13GvBpGr7T3kz8gq8WdgcyeIxMVreTYZJX11
         tnTg==
X-Forwarded-Encrypted: i=1; AJvYcCV1m3pGCytr+HRlRtPxe5Agxq0HEMVMt7HZhkaOUE3u0Qn4ctk5+mk9Hop2iKCCJct1nGCMOfEv7kOkw+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywGMFRmMSd82j/s9eR7Gzs2zHeOTZyBnrESJt8LwcdsLO1z3q/
	J7r7ULqiFiIxcmGaZ2mwUVEZdvnD+UWoCNj3we61czCsmdx2RjmLUAQM
X-Gm-Gg: ASbGncvaMD7nN2qBwbGzch0iMA8EB17BBxVAAK1k7I0DOZPcLkBgXWXzBick3s1dvWg
	XvPzRe/SbxsK4hb6ONUc6kxyRTx5mA8ra2Pmqg7lj3s2QGCrL3T+PU35IVVP6/d0jECZ6o/71J6
	DVF7q9kY2pbvE9FfMIJaWIT4MYiDN0JZX+dQoYKRyTg+AEWEK8RQ6uDjmfXEPCpTleZgKNNvYFD
	uwsAhuGLXryn62yl2rYdUbyYqxX8tRxy6q1rdFwtPMWaLTxejEU3qyWuoUDfKqle9hrkCaPfHWf
	6q8coxJLOlIw+zzuT0y8pQuI7edTVXpddMEDJU/C+xd7BHTu54B/nBiSU3R4wCrDXuvzFHG/quP
	fns3llFhK8ggvKGlcU1pbPSxw2TcJfACega3tZI+regS+csFJf5fG4Hd5B7NNNakR1HDWQMPOIQ
	Q7JU53
X-Google-Smtp-Source: AGHT+IFVnSebX+tve6ow5sKGnu/YjQAUbucUwHpAyxG58VlkbMSagtb5MvrLUf3x+LSxMJMf4HjlNQ==
X-Received: by 2002:a17:903:286:b0:295:4d24:31bd with SMTP id d9443c01a7336-2984ed45e40mr49939405ad.17.1762972196331;
        Wed, 12 Nov 2025 10:29:56 -0800 (PST)
Received: from localhost ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc9f8f1sm37254355ad.54.2025.11.12.10.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 10:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Nov 2025 23:59:48 +0530
Message-Id: <DE6XHERVPQ7Y.163VOB8V2BURD@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <criu@lists.linux.dev>, "Aleksa Sarai"
 <cyphar@cyphar.com>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>, "Jan
 Kara" <jack@suse.cz>, "John Garry" <john.g.garry@oracle.com>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, "Darrick J . Wong"
 <djwong@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Ingo Molnar"
 <mingo@kernel.org>, "Alexander Mikhalitsyn" <alexander@mihalicyn.com>
Subject: Re: [PATCH v5] statmount: accept fd as a parameter
From: "Bhavik Sachdev" <b.sachdev1904@gmail.com>
To: "Andrei Vagin" <avagin@gmail.com>, "Bhavik Sachdev"
 <b.sachdev1904@gmail.com>
X-Mailer: aerc 0.21.0
References: <20251109053921.1320977-2-b.sachdev1904@gmail.com>
 <CANaxB-wjqGDiy523w6s+CDKpC0JbQLsQB6ZipW20jieNPe3G6Q@mail.gmail.com>
In-Reply-To: <CANaxB-wjqGDiy523w6s+CDKpC0JbQLsQB6ZipW20jieNPe3G6Q@mail.gmail.com>

On Wed Nov 12, 2025 at 11:30 PM IST, Andrei Vagin wrote:
> On Sat, Nov 8, 2025 at 9:40=E2=80=AFPM Bhavik Sachdev <b.sachdev1904@gmai=
l.com> wrote:
>>
>> Extend `struct mnt_id_req` to take in a fd and introduce STATMOUNT_BY_FD
>> flag. When a valid fd is provided and STATMOUNT_BY_FD is set, statmount
>> will return mountinfo about the mount the fd is on.
>
> It would be great to add self-tests for this new feature in
> `tools/testing/selftests/filesystems/statmount/`. These tests would
> serve two purposes:
> demonstrate the functionality of the new feature and ensure its
> continued stability
> against future changes.
>

We are currently working on adding selftests!

You can see the progress on this branch on github [1] and this commit
[2]. We will try to send a patch as soon as possible.

[1]: https://github.com/bsach64/linux/tree/statmount-fd-tests
[2]: https://github.com/bsach64/linux/commit/9ad91e5e2f01d5c7a8ac24b6e13c79=
42457a5270

Kind Regards,
Bhavik

