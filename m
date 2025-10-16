Return-Path: <linux-kernel+bounces-856716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57451BE4E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE035E15EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F120221F12;
	Thu, 16 Oct 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cch/OOzs"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583E221F06
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636338; cv=none; b=QMigTy/osmScTPn450HeZi3JbZYIn5Zo+xsyyxa3d05ieVV5S1cPZST5qZVlHxzNPRDQ7znoQ20kyFxJ8/7Y3On89eMLnMntCOYkCEUZa9SGruhQdbZL5KVuIworPJ9G6U9GogjfroWB/nu6m6+jHY6U+8fjQePFdeNOcShosrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636338; c=relaxed/simple;
	bh=7Er/9PzrT5s6mRhoUcGD4krlbLek83Ghswg0KJsTpNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCfUt/L15B7ACk7V+ugEYx6pQ/bpEw3kFpbzat5pl0T/RrCJ8Kmj8MLY8rExfQRQ07q++dT0m1lr+NYkN2YmJcJV4AXqjl5zTADZtU78zb1kX0G7o/t4vKPuShVSQqzv+S7hHPs4ai24yUPv2Ig/vJ/mmEQNA+l+lZzNWBtyvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cch/OOzs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eceb38eb1so12105765ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760636336; x=1761241136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Er/9PzrT5s6mRhoUcGD4krlbLek83Ghswg0KJsTpNY=;
        b=Cch/OOzsLYGnR8++ug6EdtB1mGx6D9wxdDbVVMABQ9wM2bDGq8vpURtda3zrV3QSCa
         cCXZO5BACGjFolMfeuVhb+pz/+o2qZB9fgSNyW5L8o08+w6cIZEKzg9MLEGjlGX/jUuL
         8i/XNBLZ/McyNQgv8UThNXXYlvF+tAgzFAZAx5gekEc7opPncyDH3TcGfgiK59wrFTpb
         ZnTwuTHL1Xqk0tPM62kCNyOX5dl48rVr6BSW+e+YXkwHS/xJZgXzH5ynU6jml+YbfAAZ
         8d6xb5WqDuQ6leyyeB+W2cAGxGX2+Af3ySuIgwuxmt6bSn8V+K4MzNDV7zJMG2vBSgrr
         92mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760636336; x=1761241136;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Er/9PzrT5s6mRhoUcGD4krlbLek83Ghswg0KJsTpNY=;
        b=khlHKh0y99BFr4Ruh73sS/GTkEwBXP3eJ4FpUX9KGcj85fcIuw4AxygA/dV1qyeX+z
         AlPNkNMTz9OaWCE15Pmx+NTG9e28tJ60ZQaxv/qLa4nbMNjt/3+U+DDe/0s5wkx4QL5X
         c/ePG3R1Xq/QVbIVOjNahdlKZ4LaVdyq4qsXfI/1ieNuBK+8b0JuNwAEOkLWj7ifdXJV
         nfXvvoFNWKb9y5t2COweRMT8Y/SSnb6zNxJycFyE+04h3iTlkGciYG7GhfB7bUO1w7lx
         gT7uBflQ4Tctd6amuKS5AIQAWOFP2hPRr8Ssy2qF+cxPHOR/b2maIO9lxCJNHOl4IZet
         lMcw==
X-Forwarded-Encrypted: i=1; AJvYcCV1hyeSklCoxb12M5TnpOdQqnBZ3yUWDZGxpsQ9GSQRrtGuF4Sh0nHc+mUOlVUCAoATxwuW8OegCmdZYKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyH5+QkZaVoCyLp6qhyOILZle7POUkr32qZyaEyvNtHLzR9QM
	1PailA59NkQBmo3mfKOFfthI5Nvukak336bOfxwYRI47zBPBCmVr66Kk
X-Gm-Gg: ASbGncs0J5T/mF7ZmRUwvq9fq4ofqhayOyI84suPA4m4F3tv6GwnSJod4dwhhUveS0y
	KBzYO/9doznA+tq+Mk8LpCLUxdjqv1xEzlOK+0ZZlxviW/1QqCU1y3THFHghFsNfQ4UBaj6DwqE
	Sq/nVnRXYhHZVhzcW5ObEFbU4ZXk7raBumEBPhQJIW2piF86roUZv4WPaYcUw6P5e49fWhmOiPN
	WPLVCWJEqWb2YWIkFhwGVoQxyAKSkRluFtv8trs6g15nW0vKrM02rwO032uNcPtnFIpHOTzixJf
	xnEIe0YIP3bshdU19VdRhCA0JrDKUDgPWw6cH7MFUHov/LSBip7fDTIj7mlkSeuvUWbkh5Tcpyn
	0tORL6YnHID75pUGaYjOt+85hQ+v3AuX8wbkOaNkGf+I9IJBi1Y2MnQ+ulc5ARWFthocvs7Z+5T
	ULmnr7ccZk0NHQM2H4hbZzEwY1/ilzIlF1Jzg=
X-Google-Smtp-Source: AGHT+IG8ofuaCOl/tx0AI3xaFGhoKVgfaZ7bskzpCPhaJ0vcwXl5dX0rZWjp9TrndrqOGJk/YTNQUQ==
X-Received: by 2002:a17:902:fc44:b0:27e:f16f:618b with SMTP id d9443c01a7336-290ca4f9b44mr6987745ad.24.1760636336486;
        Thu, 16 Oct 2025 10:38:56 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fe4f:64d:d8b0:33de? ([2620:10d:c090:500::5:b51f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290a382a927sm32356755ad.106.2025.10.16.10.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:38:56 -0700 (PDT)
Message-ID: <ab6554712b0f23b1a64154910f77ee47fc596c18.camel@gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: Fix memory leak in __lookup_instance error
 path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, open list	
 <linux-kernel@vger.kernel.org>
Date: Thu, 16 Oct 2025 10:38:54 -0700
In-Reply-To: <20251016063330.4107547-1-shardulsb08@gmail.com>
References: <20251016063330.4107547-1-shardulsb08@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 12:03 +0530, Shardul Bankar wrote:
> When __lookup_instance() allocates a func_instance structure but fails
> to allocate the must_write_set array, it returns an error without freeing
> the previously allocated func_instance. This causes a memory leak of 192
> bytes (sizeof(struct func_instance)) each time this error path is trigger=
ed.
>=20
> Fix by freeing 'result' on must_write_set allocation failure.
>=20
> Fixes: b3698c356ad9 ("bpf: callchain sensitive stack liveness tracking us=
ing CFG")
> Reported-by: BPF Runtime Fuzzer (BRF)
> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
> v2: Resend with complete CC list.
> ---

Thank you for the fix!

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

