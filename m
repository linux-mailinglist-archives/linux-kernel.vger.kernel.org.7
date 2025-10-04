Return-Path: <linux-kernel+bounces-842106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A7BB8FB9
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D299B3C58B4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0021627F010;
	Sat,  4 Oct 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEBuwWWA"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01827D77A
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759594580; cv=none; b=ZS3FTgK8JVh5nJbQW+yhtG8CDJthNNwoNOGPq3FkBWt2YQC91nBv4Ditp5zty/gTOlaGCy2n32OS3sYbavcvO+77XC7QkN5uZX9gh34DqV8RjFcXgq1lsVDMMY7LWPHksT40JaPlUrYwn4yKlVHNSCixY7xrYs6ijUpfERCB9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759594580; c=relaxed/simple;
	bh=BFtFWz45fCHfJppYTWPt51ZzCzGvzVWdQH30FH6IQUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwwVUMJjVCbuQ5K0/euokia83gzwtlELGIMMOt53Qop3fhbJepv7LMgQ+vos3vpI+AX76Rv/LW1ZVLQrHHt9xKcmsoJdEPogb7EexvfFFO6Tmz/6DXuFQeyQ5i39CxRJjDabAxAdEtJ/jGXNgr7niiAo1sR8CsE+MKAFxHK8Vek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEBuwWWA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-421b93ee372so1558067f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759594576; x=1760199376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFtFWz45fCHfJppYTWPt51ZzCzGvzVWdQH30FH6IQUc=;
        b=MEBuwWWA9jG+HkRdcJFUB/0ltpuZgooele6Ye5mDK+4vq96J1dYnFPwL77ItXw5KyF
         6LhBiMF6o81Mb5hhyyDhYnILOzIBLgTZX2m1wQw3BIofmoya+kdnDViUNOCX2sQMswYH
         uWz8xBj6op4IWnPsAN2atKfCuL1V9wIgBom3uDtrZb0J6kH31fJmIOeUYCvYg3IMKffG
         Zx5B/lGX54JMm68jvoLD5xYdiJbNd6R/Jc0xit/8+g9mohzPHsW0OqK1U/A5glGdyEWP
         z/Tc39KnyDXiMne35jPL7ver7a2sfWgg//dDYvCpANgGoIsXQfqrSyh5+vInGzKFYrB9
         j/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759594576; x=1760199376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFtFWz45fCHfJppYTWPt51ZzCzGvzVWdQH30FH6IQUc=;
        b=LuV5H1xv9Z3eeOZvwEOmmxr5QXOr5KkO6/FgO7PEOI7c+par8kU6LTH1FhuC56YXmK
         LDZ2P/bVS0tOCBCu0Gtfj2C4sZH3aA24fDKgOWE7COltcPdSzQf5ZxlouH494tbBYs3M
         4Ma3730vJK32Fww+j23dQWHxnXIstfhPZ4/YgDNPJ0f1f4fkAFt/0RSLCd/J/A7IiJx8
         GbCxZ2vBokYATiRD0t4zsgX6uyqXLiQquBtHzyyxjIxuuF/fC5LVK3/IBH4ZOwnOQZUV
         7+0vk+6Ul1TSs6NkLBwtdlswIrFDsPZxn9xlRbEYuCx7vor9xH3AY9mY0oK7NXH8Pa6R
         NywQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWI8zrOsil7/y7yR6ff8c17Z2GvjSDX67v9xR5CzRKnM7xFR3SNo1bduC6qDjdbJU8xorVZ5eZco3sZC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQP5dQKO6At8icvu5NNSiKtyW82OH/nxYFnz+4q7CG1uyroUiP
	dkq+EThtQMdimHmJ+NJUAA+kUMq9B/iosiAvIh3uB4mzircUkSDZg6SQvlONJgLtx+pg5figjAP
	CX+CeEzWMg4Ms6+HDB+zxjBNGnKc2hXk=
X-Gm-Gg: ASbGncvAKYMfmTseoNgb8vWu3iFKLSDsTJ+PJqk81SJNWlnLETQxYZU/mjldtQ2FEh2
	oxFOI+z4PVSkpmptE21cpleZMKgEkT3TQZ5VCcQKi3N9m82j6d/Ii49/J/nyr9+6VRWv1pAeGOJ
	zyF6KFQEuKo/B0kOdoA7HM+U4RVORs7FO6hOBGyq8P85/QbL86e/rINp3mGMISeMXHWAlZ1jlAC
	wHw5RwMj6/8W2ohUBYFW/W37rvtQXhnGR9cKMXfbuOIH75VxlJtyU81sNzDEcKLQDlrJOA=
X-Google-Smtp-Source: AGHT+IG/MV88gOTgIBtKglK8w1B5S7CgfnDOr0uIJuq9YH1xAWacU7h3e14hKjJmdWrb0tfBYx6T3oHJx47i8VNfTVc=
X-Received: by 2002:a05:6000:2401:b0:3ea:e0fd:28e8 with SMTP id
 ffacd0b85a97d-4256719e9c6mr4129999f8f.32.1759594575949; Sat, 04 Oct 2025
 09:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_1259E1972E2A9FAF3DA342882306E1421308@qq.com>
In-Reply-To: <tencent_1259E1972E2A9FAF3DA342882306E1421308@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 4 Oct 2025 09:16:04 -0700
X-Gm-Features: AS18NWCQqriAfAUku8dSRijSYcwsuw4WSLelAlUXdhySmf6if1b2NeynApQdIj0
Message-ID: <CAADnVQJ5oEi0iiS+_N1f=K+0oTdDswGiESrd1tve_F_7aMOCBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf_doc: Support 1st const parameter of bpf_d_path()
To: Rong Tao <rtoax@foxmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Rong Tao <rongtao@cestc.cn>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 7:24=E2=80=AFAM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Since commit 1b8abbb12128 ("bpf...d_path(): constify path argument"),
> the first parameter of the bpf_d_path() has been changed to a const
> constant. We need to modify the header file and bpf_doc.py.

...

> Fixes: 1b8abbb12128 ("bpf...d_path(): constify path argument")
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Thanks. I reworded the commit message and applied it to the bpf tree.

