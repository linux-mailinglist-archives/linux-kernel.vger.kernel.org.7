Return-Path: <linux-kernel+bounces-868489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39101C054D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42CDA4F5369
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBF308F39;
	Fri, 24 Oct 2025 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjUxcFk1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371D3054FB
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297637; cv=none; b=cx2urvonoLuqQmBrE42xBfdOmcfZ9kqPQqjhgI3Z0NGYCrMiwU+sgQpXcWWA59JAEAb4/goehCJbfE284XYWTJ6QFvSSw/MWUfSCwAjvZDm26BBahkHEqRM1cUv7bgiMw0XA3HGD6h0d/GReGNEmZEnoZN36J73U5LEHjoTSUbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297637; c=relaxed/simple;
	bh=KRYLOMYrQ3kyftsmR2kiak9aO8LPXyN+XNVOuRc41dY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wu1yE5nRM6wHcKAsbmfZ5Sb6j53M/ZtDEX4WkfZysIZNBAjHjP09ijC+Ql2PLO9SivlzRQj6TTw32uCo0WdUXesR8ru6ZSR1+jNHI9pjXnhmdjYQQ6vgkDbQAwvjms27BVuYsBpxsBLv0uyQe4Wo31LcPlDfAvA6A40A+hEkFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjUxcFk1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761297635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRYLOMYrQ3kyftsmR2kiak9aO8LPXyN+XNVOuRc41dY=;
	b=BjUxcFk1YByUiwbMMaATMl0JbLinKT6N2RU6VJ3AEg5lc6WJnM6d6p/YuUxRLN8qSPqTXv
	tth0r3ozsdyJqPuWkjypnrd9AKPfULV4rdI64Cdl7Yd2Qoh8UKbmWYJnrGkTpC8jMLeJws
	lVzaTdpb+1XUxM9b4Nd2mpc1Q4luRiY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-8aE6XJ8RO-mTt4CgWYjm7w-1; Fri, 24 Oct 2025 05:20:33 -0400
X-MC-Unique: 8aE6XJ8RO-mTt4CgWYjm7w-1
X-Mimecast-MFC-AGG-ID: 8aE6XJ8RO-mTt4CgWYjm7w_1761297632
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso1614383f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297632; x=1761902432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRYLOMYrQ3kyftsmR2kiak9aO8LPXyN+XNVOuRc41dY=;
        b=JUJ+l6bF58ZfSK3k5/IruBm804mrhwdacZ+QF7HbpLNNrSTsDgdJlXFqjzXtV238nN
         BOKtxvDGKhgZMNetoakTadsIfcmMBg0wjyPg6yUbEFFZTj78ZeLhhUqIbtU1O/In8V2v
         yXLFkSp2aVAWT+UiUF1JnEzlzfsgLd1canuLXymBeb6mykaiQAxOfTpEW1OmjzGC8Uu3
         39ullIJAkklbmN/Ey8DPg12MJK4vELzqI0I8QHUzir6hHv0BVTAlTvbdxqCA5EPs6F3v
         Z/zbCkUKmA92Yt42xogo24tF/q2Z64Vs7Fm9DApvspQMV760kdbojf0ICeBfjndDOpNW
         5Vbw==
X-Forwarded-Encrypted: i=1; AJvYcCWbj97flyYf1RyRbSInUFm5rHOzTZ2l1LfbxPx9NYSb1WzmgCqlR2ZESetd69V9FzlMzm2C/DSol9xZDuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4iPxjHggySdmG00BMt3sT9xINI1n24IvxOAIotWkskK8pOK8Y
	sp3NHsz/o039BcnjjpqujP/p/QMgxQoneR+c+QN7NmKjJoCJqCy9WvGdXDc3XUhfTjbbQMTIXp1
	dX1bzJ/Doay98zs0i54nPB9RCEwBMcAufHEcD5MH23o+yeXyfbXW1yq6+olLDYYL58g==
X-Gm-Gg: ASbGnctEbnAKyxawc+IN5TfJ0KxYnS4gazMkkDPdxkfW3uz0OqYuoYoKvQD9NDsjaAP
	kBbxbqGUo6SoOHn4Neab84vMm10Yyfw/vDo/TBgsXXoOEDeBqX6oYlaqTJTsFXbDAEnym4i6CkU
	jPxo3Nv/z1EC9WZ5lfNfMl0fG5rLVrqkqg/m2n3EKkLPVmMPd6Me24wpikgTXyppl1pKy3oTjlJ
	3cMcbCTZQ8v5UloOWvYH+fuYpmO4M+9iE2rxgxHpqrzUpDlA344Uq4bBZkJm40JAuwzhvSpy0nJ
	W3VoOO3rUI5TwNQIumm/9phtDRB506hpQp7AEg2HcnABK0hF3UrZv6IeGMH4bqzqQDu5v9HUaYL
	kLKYgTkuzuaYkFrgLrodVTfKC
X-Received: by 2002:a05:6000:2209:b0:427:67b:b385 with SMTP id ffacd0b85a97d-4298f5284e0mr1475125f8f.11.1761297632390;
        Fri, 24 Oct 2025 02:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENJCKEMSHznuwRnoZo8gIjMg1xMxlZlosiTdgr3BzAFIk2sdQW9RZpNtz+ul6TzEjTgkBYBw==
X-Received: by 2002:a05:6000:2209:b0:427:67b:b385 with SMTP id ffacd0b85a97d-4298f5284e0mr1475098f8f.11.1761297632034;
        Fri, 24 Oct 2025 02:20:32 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ccd88sm9981862f8f.36.2025.10.24.02.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:20:31 -0700 (PDT)
Message-ID: <89c01961393210e3623b6d556e722f145d6cd557.camel@redhat.com>
Subject: Re: [PATCH v2 18/20] rv: Add support for per-object monitors in
 DA/HA
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Fri, 24 Oct 2025 11:20:30 +0200
In-Reply-To: <87bjlxokvx.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-19-gmonaco@redhat.com> <87plag1nb6.fsf@yellow.woof>
	 <866f10440f9edde8acd34e5a5d2965719ae5d723.camel@redhat.com>
	 <87bjlxokvx.fsf@yellow.woof>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-23 at 14:36 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Ignoring the vagueness of the name, the two implementations of this hoo=
k are
> > to call an allocation (yes, always conditionally) or just assign the ta=
rget
> > to a pre-allocated storage.
> > Your suggestion of da_monitor_prepare_storage might fit both descriptio=
ns.
>=20
> Now that I have grasped (or at least I think so) the patches, it is not
> that important to me anymore. But still, having function names which
> precisely describe what they do would help new people understand the code=
.

Agree, I'm going to use more meaningful function names. Apparently the
kmalloc_nolock is still getting lockdep complain on RT kernels so I'm going=
 to
keep this skip-preallocation logic as it is, hopefully just clearer.

Thanks,
Gabriele


