Return-Path: <linux-kernel+bounces-736110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A3B098EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844275A1997
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90321EF1D;
	Fri, 18 Jul 2025 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgWc70Gp"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA3DF58;
	Fri, 18 Jul 2025 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752798323; cv=none; b=pY7nQoxx1UbHblcpDgQnDp2vLOi049sYdwwvMAfnsRStwGt35gny1lV2oYkC/hipmHvqaMNwawOP4hwdh7FS1B8JO+8dhdm1JmqAaADJz3wowMl8fIkzUUwT/ygG2rqAIWBEHhI6olb8bcLMbDGbwrpiDj0tULG/sZkLsevdYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752798323; c=relaxed/simple;
	bh=B+YjNzfyGTMgLUF3A4KThJGQZuUESElD7YkMkSQbPsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzmyX5Dv6QgwhSbBacoypSN0RwCmeNLY/R1frS/N838Fv2sVHjwTBRA0cJbRGvzU57iPv8aNTJ4kqhkffQfJCUW998IuWr5M2C/+w5ZgpPQaCvxFRRd+gMuttuqwxve6OdHEhv28tJu1A5XeeU5yUDZsO0hpHEsvqeFDLKs/cnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgWc70Gp; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71840959355so17806937b3.1;
        Thu, 17 Jul 2025 17:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752798321; x=1753403121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW/0Zmi/vNH9EEr/OpXm8ZSn2rzhu1SEqp080LbfUMc=;
        b=WgWc70Gp4ciwCIkZxZ9Ur2b76W7W2ILDm4Gy0/s2i0KOQyzoxNGEULASb66jDjj7kh
         qvsmrNWc7CMj6LX9PTu9KiRdX2DPPVIivuAXABCo9t5sLmV77A69V7hWVDccfmqmZhc+
         q8CJ8AVVsAusZCyrKirxDpS6iMRoSdHkbwsj/rXYXg8Zl1V0ATwrXYhZ7Xvcvx9ixmHo
         Wjk6mShS84scI+l/iYuQ6leyGwzTEWyHYp2KegMOPv4ZGzZ40l+tgj21tBQYO+cYKQnu
         Qog72+NcFc2Vg3ho3u5xVcSBOjLZQzNHTTR6Bovp8T3wabgfla4d7KV183coADPXE4OV
         s/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752798321; x=1753403121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rW/0Zmi/vNH9EEr/OpXm8ZSn2rzhu1SEqp080LbfUMc=;
        b=d21n6Rmhch9BI+gQsJZgf2fFAmQXM48lTw1Dlaxu5VKZxBXR4d6G54yGF/bhSVOALZ
         EKeW79nENeaqeNm4DQaL1b98PLvjdVB+yzAknrpC39prr27nGVKkwb97utCq+JuIu7Hm
         DbOltpz4i40jLZpwvPFD/VNHE2rFEj/82wBwPU2h8hLKDiCRdnZ6I5ozbiUi8L0SEliB
         QRBbts+CYE8Fet9dkPiyFm525AypXHlVJmS/ZW0WXN4mgMUl4O27pkl4knTTlzGyeOwe
         +lriQUEgtkLrNN8oC516LlVpX7/V8KoKAQG1QJY22VA5QlIC74X8UMG+J4k9UPCrVxU3
         e8PA==
X-Forwarded-Encrypted: i=1; AJvYcCV5S4j9UHm5yUJgsuzooVZ2RRCj7799K7PQFzao1k0w6lw3GC872Gl6xCwFBTrpsmoGcvGPhmnjlfw=@vger.kernel.org, AJvYcCVASQJ6cX+xNhEt7u7GF61+XPmyGDr8CTqkipkyqkuP0vVLrm4Wbx8mtK6hRn15jQFZ4vacbgLw3DG2z84S@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrkMp2aB2q6/BZh2RfrbI7EebSMQJe5ALKJepqOP6WMYgimRG
	rpfOFRxzBzM5NjBuhc+l1Riu5aNF7mi7LETzfexqs8/Dj7yRLykPSK1oBc/VJGsDx4hIIARVaH2
	BVrQ8h465jRnSJDwbJWUzHRaFDzFMTgE=
X-Gm-Gg: ASbGncvZ8SvE8AWc61FMaDnyecQTURl+tI0QIznsplnu9uQGjnEuP5fpZFtW+lgf/Z/
	A5LuotlMGQonRIg7D2E8q0XKolQXgm1Nq8XYjdoaKlSy6KVqjL+GrKW6Cbs/Ay0wyi6CPzpgIPq
	DkCSQZBOUBYTsDXKomp6EfqxWOxo7I30iBagsVR5gVQSnm6VYZaustXyvxhO4Mbp6qZDwhDqGS1
	ZsuYvHERg==
X-Google-Smtp-Source: AGHT+IH/pLfJsdHnXSt9Ly8ecX2PqihbzfAzEbKcHlMltmShqJWQ4n7+H85DNhIvc9e6ayCA/nmTT0bgIAd3bZOIKVU=
X-Received: by 2002:a05:690c:306:b0:712:d7dd:e25a with SMTP id
 00721157ae682-7184f7477eamr77570237b3.6.1752798320642; Thu, 17 Jul 2025
 17:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713163418.1459-1-zhiyuzhang999@gmail.com> <87o6tia8ck.fsf@trenco.lwn.net>
In-Reply-To: <87o6tia8ck.fsf@trenco.lwn.net>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Fri, 18 Jul 2025 08:24:54 +0800
X-Gm-Features: Ac12FXy8fE_d2Qy5BIGg0NpB5WQHAWKJ0EU_-a2uxPmcB1yEqxeRY_N24jdHFXc
Message-ID: <CAD-N9QUBDeX2tU50i292Rm8MGeGZ9icnxkb1pAVDYi+SYCdefQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: add origin commit identification based on
 specific patterns
To: Jonathan Corbet <corbet@lwn.net>
Cc: Zhiyu Zhang <zhiyuzhang999@gmail.com>, dzm91@hust.edu.cn, si.yanteng@linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:09=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Zhiyu Zhang <zhiyuzhang999@gmail.com> writes:
>
> > This patch adds the functionability to smartly identify origin commit
> > of the translation by matching the following patterns in commit log:
> > 1) update to commit HASH
> > 2) Update the translation through commit HASH
> > If no such pattern is found, script will obey the original workflow.
> >
> > Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> > ---
> >  scripts/checktransupdate.py | 38 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
>
> So I don't have any objection to this, but wouldn't mind hearing from
> folks who actually use this script - has anybody else tested it out?

I=E2=80=99ve tested this script, and the new origin commit tracking
functionality is working effectively=E2=80=94it can reduce the number of
commits requiring updates.

Dongliang Mu

>
> Thanks,
>
> jon
>

