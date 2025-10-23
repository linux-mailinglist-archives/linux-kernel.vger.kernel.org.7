Return-Path: <linux-kernel+bounces-867307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24002C0237A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31871546036
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046DB33DEED;
	Thu, 23 Oct 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxse0Xx0"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80933C521
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234169; cv=none; b=gCbwAgu63DrK//zBpqrBEGW0eS44J7PZDwBXrE7ZVL3d2W9rKCcsAnX/Mqrz/KUGBEJ9Pwjpr2oIOAC1cwCtbQ2HWC6FzJMysA3/tY+m5skmL70QV8S2L746lu9EVSDL6SiNc0a4XyQSGZwLNjUkOQqi+B5GpO4Dzl0xyKJrch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234169; c=relaxed/simple;
	bh=q52XoYD9UMEeNWx8+kGq3GYFr3ugdoKh0p7BaDkyaVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kL5ggHkHgnEGlCrr3rs0+rcf0wk/MizpNc3oQKJup66kVde1BJoWwH8KKZPKCs9vPbSWrqCoj7I9QSUkKbrzMV4i1iGwT1ty1FoVQ42kUkFWS+X1NOxxIQCaWPVntKPMNDgoUGsAuDsPPsGDxo71BYFRTPNs3WkgtwwwtyWEMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxse0Xx0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so5723635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761234166; x=1761838966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q52XoYD9UMEeNWx8+kGq3GYFr3ugdoKh0p7BaDkyaVQ=;
        b=Qxse0Xx0vrmoBcXp2XCcSG2yRPM2k9DmsP62D609Pa1iuIsvDBSk0wdybNGsqqzCfQ
         NcQb1cnWODKUlL+W+IVNV7Dn+U/XVb+wxbeLKZHXmUzt0wkNjvvAI9grfsHhuZk5b+Lp
         rOHoHrvvrzigN9RekQwkOoNP4cmw48l7uNz10GedHzCYPqWwrEqxQTDPDobH63rovtIy
         mNj66De5famlJZlvJCtB2VObAMv1bLchIsfMHLDO2BxltRJJtDGKvPOMg+o09q61Hy6T
         pipjOIppOo6BtKWdnSB5I/1iBIbb6YgMKGEywfs/JAVLgWBkiydq+sJ9eyFTw47N//7R
         quWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234166; x=1761838966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q52XoYD9UMEeNWx8+kGq3GYFr3ugdoKh0p7BaDkyaVQ=;
        b=M43KmYIAr9daUJoQCBVn6dTtuY2MnHWRSRzITfR2K5TmEYgR6TY22MKa8XsbKTjPNm
         +1rs0QU0MGuLqu4Yy33V3RGnAYX0NMEwraUEtDyxpSiFeiPc0qFlrFW0XPlna939qFSD
         KA2HPekjwfhNRUoRXlnvji863E42g6PS+Zzre3B28LKklKb9n4ZfKwDPbpmv+d/NGjQr
         SAaXpFMcnPYsKwkqqqp3Dxb+/fDIBsFJ75OjG4hCeGsrtFFdGrCrET72PzWb1oC4Di6H
         NFiPN4LYZPBlNwSniGtwaIC5dtVl5Yko5XvCt66SMJ7K5AqaL4ofmFBSkAMFHxbUMJxD
         RcKA==
X-Forwarded-Encrypted: i=1; AJvYcCV3g+seD9c8ICjkkW2vt1kstZb+g+3Nzf4VGpVVzU7FiAXQJoF1GKAJv7lFoUjMP0vwI6qI39XmrdrZXMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlf2X4lerW9uigDTM0wfxJJvP7Ygm2IiJzENFxrMJTKOpilbXB
	DpWhWqzumbLaOeuyYLF+MezqOIOIx2Ay060ML5stVH4PDta0iVaDZXz613fZfNrzUeyS1UNxdpu
	E3EUM1hWO1zqfxIXQ0cvR/6aiBwyG7Zc=
X-Gm-Gg: ASbGncuGf1We9f3VZmL/S7vTijhKQMnPuxKrO5LjO6TtzMwC665ccJw1Ohh2+Cnhgfc
	DwPuMcvgbsZ8eOmbshXDvAJTB7N6+2gDfMBs8NLbVHm533t56JOsc9m23UFh/2jY1kDt2eMk312
	q0sAtd2bVH4Howu0kJFQZssSR8wVkx76OhMeB+8iNPjfIw/MjpuT5mYKYiAJjocKZnItzVoPj8+
	VRr8NQEfCh/rkNYq6g5XpJpIJMupc1EK0c4GTAS60/GioE+2Lt+bxhXyGYaMA3NKrD9I4RjTn9F
	//oE1kcSl5lvmycN9lk6Jw==
X-Google-Smtp-Source: AGHT+IFhow4QI7xwSMhlDLZ5U1ipuss1H6Ff92i8GV+W07OMa+jEx3VQ4ocR2Em4KUSzfNwGqYXyynb9DW8McUjIsPI=
X-Received: by 2002:a05:600c:37c7:b0:46d:3a07:73cd with SMTP id
 5b1f17b1804b1-4711790c31emr150922395e9.23.1761234165874; Thu, 23 Oct 2025
 08:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022071825.238909-1-jiayuan.chen@linux.dev>
 <6aa7fafd-30b1-4605-8b80-4a158934218d@linux.dev> <0643875cea56f4e4fd78c7e9222b24e269136155@linux.dev>
 <84906f32-955d-4fda-b87d-56c052ddfd87@linux.dev> <8a94c764c5fa4ff04fa7dd69ed47fcdf782b814e@linux.dev>
In-Reply-To: <8a94c764c5fa4ff04fa7dd69ed47fcdf782b814e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Oct 2025 08:42:34 -0700
X-Gm-Features: AWmQ_blQXgPilzRH5-JKjp2M5ciDOClA5vPCYZnL9G8qXyDh5BpMORYPoCvzAh8
Message-ID: <CAADnVQKNpd8SCawQbW69ALWNZMoOvxwRbBQELqzh0P52iXG=kw@mail.gmail.com>
Subject: pahole next->master. Was: [PATCH bpf-next v1] selftests/bpf: Guard
 addr_space_cast code with __BPF_FEATURE_ADDR_SPACE_CAST
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Alan Maguire <alan.maguire@oracle.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Puranjay Mohan <puranjay@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:50=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>

>
> thanks, but version 1.30 didn't work in my tests - even pahole's master b=
ranch fails, only the next branch works...
>
>
> It seems that the 'old' pahole parses some kfuncs incorrectly, for exampl=
e bpf_dynptr_slice().

Alan,

the introduction of the 'next' branch screwed up the workflow for many peop=
le.
Let's remove it and merge everything into master.
People expect master branch to be the one where active development
is happening and the source of truth for the latest features.

