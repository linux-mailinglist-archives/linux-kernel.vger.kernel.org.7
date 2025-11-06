Return-Path: <linux-kernel+bounces-888799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 710A5C3BF0B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABF544E5568
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DBC33CEBC;
	Thu,  6 Nov 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQM4S8vt"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653D33E36D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441200; cv=none; b=pOxpQXNY1JHuxl0dTBGcj+GT7+TGZOq85+m+OmRRf8D6Hj9xZDYzszKD2sXxzZYGhmelg6xFNsUNX5QapWmdu003b8f0JvsBCarn7By12RulOpqE/hV5i8Tw4E3VSx0N+LXqCnfBRfrmlFZnEQHUxrAA5Cd56wyoAA+aEApKYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441200; c=relaxed/simple;
	bh=ojB4U0iGQi84vORYN2iwAJcLhCDT+ZMOyB+kX04ewFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgMI1RcVPo2HkYySHabMLk7iueavRIuyraQlCvyOsIRzBRoLw3IgOX7/AGue83ixOSIe2h4Prz3BXEmUyUU2T2HVg/2UfmekgtBVb32orW30imKidfslK27OKiK+kCziWun+TeHqG7VHYfWom3hp5WKELAYKKF6OxA0ZtcPhO0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQM4S8vt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640fb02a662so9022a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762441197; x=1763045997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojB4U0iGQi84vORYN2iwAJcLhCDT+ZMOyB+kX04ewFo=;
        b=pQM4S8vt4U1Y/OozUmNgyad3pQay8nolSAKzTuZh+8skMZ5C2pNlzL0Hxd2o1YI3/+
         E9TzYcTOiy69Lm0yWwqUExuDUFpP7EAzS1zh8dROenmJSoxq9rZYnRL8+dfT2tViGVPi
         8Le18aJeSBzJUz6IyAqQtsz5JOLmLZVSXFpjq5cqfMpQrO3dKWLe4iShcIx0dIUIP/A+
         P+B94kuoPmP/9cqljCKZKxTtTMmsAe/Psd3wnkeR9qvgjGz/J6BUBJA7GAphWK2HOLAv
         Kuc6wAgr4sqP7DgG64rRVh0zcK9VzGHx+0ai/HTWstHZu0eDDeGClHsEaQj0aopIN22g
         /K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441197; x=1763045997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ojB4U0iGQi84vORYN2iwAJcLhCDT+ZMOyB+kX04ewFo=;
        b=m0Hf1qw04p22i0vCf6E6ph3yzJMDLCAQt1R+3gNHHJdzx/qe0lBeKuWv4DYRXw0DY+
         FuvrwJzqG470gApSp5Po7KUzf4R7WhmYqRdQBvobd30CXb5Dq4mRqOzGhMx2V9X+2TnO
         pTpeJovpFp6Yqe/PwmrtaT9eKS9NSCFC935XK/SGmhLrJ/fFKgdCtpR9U7H/HaZ3bnNd
         YcRdfuksi5Bjp4ZW6gSFOZpfTcyK6E3+FfqxKZ8i2u/0kW6wqbFSRpgCLAsWVnH9lwO7
         J9qffR8Y02kjtC6Qh/ZDeCtt0LvTaTBpzg/hiWaYNtPN44SGV990a1bU+/ijcFydHnIf
         IcWw==
X-Forwarded-Encrypted: i=1; AJvYcCXnDurZP6gbtKsnk2Tjbo7AzZh1Qip3DHA2m9ZkRRtY+EbX3tjacz5UYDG9RclqJzZQ3z3IMQ6kjrpB1hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfaVS/0ZO0A3Efk87uNfBaYNscCYA3fxzt8URiYhZJzsZIIzN
	V30Lo1ueU7lk4mm4KGebE9UiNu59aPxb4bcljWCZ+yW7Ep0g7b5PqAGrAajhGmEG0Pg/bxtL09u
	qXOowN+kt/7VrErKuyjSVreFyjAfhiIkqYDcNReN5
X-Gm-Gg: ASbGncswi8e/Y2CtsslxUdwmgU9EZOPBZH7uDWbhedrGD+Y8XzphXne7s7getUxWDiw
	Ks/MjAnTw+oQYs/5JEmykjmdzM0jfVV8Zja6366AHWXR3wVxPgtz34YvWlRCKe7PiDDMpWBPMo8
	8MEMVR4k59WeG79+WO9dMXFdOq06UVP3IYNOXjnfqLaN/iWpR9nf8RGc/YFpovuzfBigQ/WJW8v
	C/al4QeBHN2zG/23H07llFtN0Y+yrP2kkwmOBkxF5HrbZ40B95fjPqr77C7uun1czBy6XkWPvni
	Q9wJEtIrfrjKyAI=
X-Google-Smtp-Source: AGHT+IGHdNYVXOyw8OR4JNTCRIhzO34mAiw8TBRizu2olGDPo3dCEj83yRPXDkaVILFFXq5aB2ZLeC23K52l0h7JNT0=
X-Received: by 2002:a05:6402:5148:b0:62f:9f43:2117 with SMTP id
 4fb4d7f45d1cf-6411e306383mr99058a12.0.1762441197130; Thu, 06 Nov 2025
 06:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022233743.1134103-1-mclapinski@google.com>
In-Reply-To: <20251022233743.1134103-1-mclapinski@google.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Thu, 6 Nov 2025 15:59:46 +0100
X-Gm-Features: AWmQ_bngUFoIZYbCxtoJgERO5kE_lu_Hu_xYRaDTxABTXdLwDtNKvnEeJ1GsMXY
Message-ID: <CAAi7L5cp9D6jiKSHB8yGm587vP+tOWJsK=X9--zKy066y08yoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix avoiding memmap in
 physical KASLR
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Chris Li <chrisl@kernel.org>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:37=E2=80=AFAM Michal Clapinski <mclapinski@google=
.com> wrote:
...

Ping. It's been 2 weeks. I'm sure there are ways to improve this code
even more but I truly believe it's better than it was since it's just
a bugfix.

Are there any changes I should make to this?

