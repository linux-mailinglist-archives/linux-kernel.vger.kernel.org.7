Return-Path: <linux-kernel+bounces-818945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A497B59870
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A44887B6E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75C73218A7;
	Tue, 16 Sep 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3BBxWX5"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83431DDBC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031172; cv=none; b=OVsCuhoB/b2Abh4r1n0Xj0gonxZuKNWkmFbMIIrAoGgW21vs8umKLMTyQPpMnxLNbosSv9EO6wZ1jFGZlp295ehFRrJCTxEeONqlsRD3UwbyDRYb5QtggfNK8dL6TZb3qKSUpW97ufrJLcQ+uAu02GRZytxBBOwfxsiWids+w7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031172; c=relaxed/simple;
	bh=zAdfiDdkXiV3tbwwu/omDvryeohazwZoga6t9KrFkO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1hSEE/I5kukKYrg0yYbONC4Kcl1KixGS1am0QeyCNxhHT17R+m4zwxz3SIv2VahTXxfwbQwHcUE8wjWhyMskK9ikio+VOZGAAC6SbWUMS5ZpBuMPeeFrcbj4WgzuZB5udPbIQ9ixuHa1PxGC7Y2qdt1FsVTRc8HS7+cPgY+6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3BBxWX5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f2b27a751so3061323a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031169; x=1758635969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAdfiDdkXiV3tbwwu/omDvryeohazwZoga6t9KrFkO4=;
        b=f3BBxWX5ADWUCILYfv5fensqnONjUZUeu1P+W26viY8uRZwvAzPuW99I1ofJbJlrXd
         yxMcqm5sK9m7XjAegqLsoJ0NUh0ZmfQZ4DVuWC7kvl+Vnkb5QQ9/brzlK23FiFx3UCUt
         iqdEzsY+j9KWCxdoqlBDWfF8imtbwN+3hnFfebghYZlX0IVe0gY4ZKyQGqz+L7r5Uwlh
         ZhNHqKVkAEOrnDal2PJwkmDEOj9js09mKVJO/P5JrWXgr1qOYNG2rvGGt8hoO2siuTRo
         5CoX+bteFPIiZ1jLq1bR3y7GHGO/stWFjUzjzJW//q61n4g7w3izt7d4JtaPqSLJwdMU
         RiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031169; x=1758635969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAdfiDdkXiV3tbwwu/omDvryeohazwZoga6t9KrFkO4=;
        b=SOtSno5y7ICVkRaW5cDQoZTiOW5trmRxae+TEEaOV19/DQLy/ALajz7C5kvsKu+PkS
         1ByV7N6hKunvWFtteH//TyrAaqoAehGdrr2RJXJGSn/4tLXIfgP1NELuVO8LcPMzQUeF
         DLC2aBPL1+FDkH6quzRqzRetjluwNvttVNrHg4Tf3gU7rFN6x07hk37MigtG9iyYie7f
         cxm5U9OfBz7Mumq+Y72utmHcyY66JeQ/Ni37ydjNzZWr+/ZGh2lkS8Ubcriryb2wTgYv
         Cp0g1oZxElv/zXnsOelU5S548T+h7LlvPKbuTNa/urrrjd/+irUKmSqkk+rncWJHBd/x
         U9YA==
X-Forwarded-Encrypted: i=1; AJvYcCXYJqFVBr+XJYHpoDQDoBOg14ZA0gyUsyG0A34M0ztiofceRKO8xDUCXptsPJZn78myfNJpHI2mGEfbjAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiCq8kYkzzaoRtqCdRJoUq42eysmq5WwrfQ8IBh5rW+i3lqk0
	wGYBcz0PByXP6ZnhTbzO5bRwXko7V9Y08KOLGNfjrApk8Sk4Mgokj7QYpAFVJL/w7EqzTKCSDNM
	ppyUoUFfBfFt3P/gXcMfG+QGC/WLTxj0MZ3TFbDw=
X-Gm-Gg: ASbGnctIXe/H738abfPfXyT5QWRWHvApFbgps+pZbSiacgTu1a/7oqtJujThKobrzFL
	42VSMKppdqPguTvGMbHjwwBskeEsUCkE4WSgKlNAQDQQNqovZa8sY6MJWEi2rObspu6iMbnlH7q
	amnVHLGxnyLCtyXNnedfsiPU2ikQu83q61ykzyv/DCDi0ti6Pi5A48kkUyjPpKpNkI2fVuUW3Nx
	yvgAeCRibcbAUH+H3YH37vc5kAfoBYWAyZQ
X-Google-Smtp-Source: AGHT+IEIzUyZJpCWnYGAsduHf7Qhp1qaOmIKm0n55SsVJ/ZJFB8oHVTY56tz7Pc+9DML2SHbnb2+yIG027Ug05vfAf4=
X-Received: by 2002:a17:907:3e21:b0:b04:6cf7:75d4 with SMTP id
 a640c23a62f3a-b07c365eb87mr1706464266b.49.1758031168534; Tue, 16 Sep 2025
 06:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830170157045JsLLov8_im0lUELq88aLu@zte.com.cn> <f0426e43-3d3e-4dc4-aa6b-31db8b2a2a53@linux.dev>
In-Reply-To: <f0426e43-3d3e-4dc4-aa6b-31db8b2a2a53@linux.dev>
From: Alex Shi <seakeel@gmail.com>
Date: Tue, 16 Sep 2025 21:58:51 +0800
X-Gm-Features: AS18NWDVR0dw4x7jsPMAe97nr_k16HzFbESF3SrJRor_9Uu3Y2BPcHCtbu3i-gc
Message-ID: <CAJy-Am=d4UgmLJOGmPmgWg2Z5-ODpZ=L7SX53ZmFT-9shtU=XA@mail.gmail.com>
Subject: Re: [PATCH 4/4 v3] Docs/zh_CN: Translate timestamping.rst to
 Simplified Chinese
To: Yanteng Si <si.yanteng@linux.dev>
Cc: wang.yaxin@zte.com.cn, alexs@kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn, 
	yang.yang29@zte.com.cn, fan.yu9@zte.com.cn, he.peilin@zte.com.cn, 
	tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yanteng Si <si.yanteng@linux.dev> =E4=BA=8E2025=E5=B9=B49=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=94 14:53=E5=86=99=E9=81=93=EF=BC=9A
>
>
> =E5=9C=A8 8/30/25 5:01 PM, wang.yaxin@zte.com.cn =E5=86=99=E9=81=93:
> > +
> > +3.2.4 MAC =E9=A9=B1=E5=8A=A8=E7=A8=8B=E5=BA=8F=E7=9A=84=E5=85=B6=E4=BB=
=96=E6=B3=A8=E6=84=8F=E4=BA=8B=E9=A1=B9
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> There is an obvious misalignment here. I'm curious, have you tried buildi=
ng tests?

Oops, I almost missed this, please resolve the problem and send again
with a new version.

Thanks
>
>
> Thanks,
>
> Yanteng
>

