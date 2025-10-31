Return-Path: <linux-kernel+bounces-881024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4DCC273BC
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 00:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE66B3A1DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E88330B01;
	Fri, 31 Oct 2025 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvaRmDWA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA932862C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955014; cv=none; b=OuvXr+zn7LiLSp0xVb3cVgfc12wra52PsBwfjdrKhsZ/4S6MtQfA7uXV4oOT/DJfZACsc6n1nhDzz/C2LkKg8WYz9cfIJ6PLB1OXknjJaJl2kCpvkthrYP5hP8bfaYJiFHOmro7Cqd2jRqaj7mz0obLjUeiUNbfMBpo8FZo9ynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955014; c=relaxed/simple;
	bh=bqI3w/EdVHtkpGOIjbdCki5QbmrM49X6+tmUZLIaD0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGtZyXqJ7jez8o0gns46A/e1Z7VcdenAId7uV52lJZy7ymS39WSD7vZofG5Y2zmgLeBYsKLc4ok4I9nvoMx117XDxAhmGGycDuxQTxlasxKm7Ye4iAj42VisqcGY2GakCYXeOqcyliNSdSp3HlmF8vMue9DLVbwMA11xphDYXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvaRmDWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E745C4AF09
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 23:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761955013;
	bh=bqI3w/EdVHtkpGOIjbdCki5QbmrM49X6+tmUZLIaD0w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UvaRmDWAnFi7wBp0BjB4vMz1AJ1ZfQU/5g9go+Bs06V2FMknl+OVW24moAfTUfnB1
	 G0ItuCd3mvQ6zuTSUidHo6cG2nwvHabFhtrrGdgI+i3af+hLf+6s+fM/CDvqGVoqo0
	 Py7IXhw7AqpbwqEOnMAg+17JHC5eievG+Ra8AiY5u6rlMj8mutzINyUf9aGSLgg1Fg
	 Lci/b7rcnh5Uk1govGBsGJUaeKEPMZJPyxzhTMttN6C223mCb5MFaLyKzq/dCTEpHX
	 upBXgGJJwLzY+dXoqM5Qc2wpC5f+CWVH8XCLQB3fluTmn9MrwHnKEsrqhScf3bNoiD
	 0tiRn2fmnFoxw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so5305754a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:56:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYpVaqoCiPuDQFmlQngcz1xvI/qJXmhFYXeSXFXtpgo47cYLYFp3iQ/LGI6eg1+ggS/cA1uJKOrgx16Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09gpLH0QNGKKYKwd/9CC47cpEmiGCebEJ8AU7W1zmBKXUs19/
	M5QlTKMyk+EeENSV6pawO9PBJP75LxreUBPP3A7iT5V+tx1fowXkaTd0yXikTUnUCbSqDfZ6iGR
	Kch/h41pP88ISStksSx57Ncq4K+0zySg=
X-Google-Smtp-Source: AGHT+IFS0DvMpUbXxn+6OnOchHuBTnSOE/UdbxWu85/JAWMcUGEVjijIBgVl1+W5kewyHjDwxxYBNF2xj2EPurSWu5M=
X-Received: by 2002:a05:6402:510e:b0:639:f54d:9274 with SMTP id
 4fb4d7f45d1cf-64076f67014mr4297145a12.2.1761955012177; Fri, 31 Oct 2025
 16:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017084610.3085644-1-chenxiaosong.chenxiaosong@linux.dev> <20251017084610.3085644-3-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251017084610.3085644-3-chenxiaosong.chenxiaosong@linux.dev>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 1 Nov 2025 08:56:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-DxRTEu65-YKwXw8jA478jmgQAtOUNR66Tjb+czxp=xw@mail.gmail.com>
X-Gm-Features: AWmQ_bkEZgpbfvaXa0KW49_u9vc9ThnnjE8dBjQSTUJsPOAkri7qLId8BB8gr1o
Message-ID: <CAKYAXd-DxRTEu65-YKwXw8jA478jmgQAtOUNR66Tjb+czxp=xw@mail.gmail.com>
Subject: Re: [PATCH 2/6] smb/server: fix return value of smb2_notify()
To: chenxiaosong.chenxiaosong@linux.dev
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:47=E2=80=AFPM <chenxiaosong.chenxiaosong@linux.de=
v> wrote:
>
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>
> smb2_notify() should return error code when an error occurs,
> __process_request() will print the error messages.
>
> I may implement the SMB2 CHANGE_NOTIFY response (see MS-SMB2 2.2.36)
> in the future.
Do you have any plans to implement SMB2 CHANGE_NOTIFY?
Thanks.

