Return-Path: <linux-kernel+bounces-740477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CE0B0D4B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88221897C25
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27B221127D;
	Tue, 22 Jul 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmqixFoE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCFE1ADC90
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173048; cv=none; b=I9nBGW7rbvx9OwwTFdDjrjsAGkSQ7bTS5e4s4eZhMEyWOjBUDZsIJSxGU90h8yf+QKTIM4j4KjpVyQEacxZuN5jjS1tES7YcCQvKTSt3EhRz74mk/l7K/zyDrF4WoShD5rifmVGX2eAVJLvj/Z5VanfYKmPOWh4PKRPCJkQ14Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173048; c=relaxed/simple;
	bh=QiYxraNy+bvn6efAc9zLaMPBsRjqwvrvbjsSdMT2p58=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A+ckdkRvWzcsBf+QmLBA+3p0oMU7JYXk8gMeqgLhN12/d4UMNyCykqq6SBEixH3pYK8OWBZ4c1WXQIaLrDhcpEP7Zgjd3zw7Hibf+zFKvhFqEq0GxgLzLRr76kn0S+YBQwD3iYwpqJhoZgMi2hoLUtwYsxtKvBIpSxhiKQZivRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmqixFoE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753173045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QiYxraNy+bvn6efAc9zLaMPBsRjqwvrvbjsSdMT2p58=;
	b=RmqixFoEt5RMZgG0Bo9Ge3R1AeAa9Vu4+QorFand4s8V6TiUfcK71Hnk0Hi//IW5vtJPlc
	Mrn594gJw+ZnmOXF6aY1PHO3W2jRb1ESYKD1nUI4Cs2EWAVB1GhZv8j7p08J17r7+MuZ9d
	huik5ixR8lT15wkN7Tz3YhK/uyZcVp4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-iPIZ2JadNzOyj_hpX_KNiw-1; Tue, 22 Jul 2025 04:30:43 -0400
X-MC-Unique: iPIZ2JadNzOyj_hpX_KNiw-1
X-Mimecast-MFC-AGG-ID: iPIZ2JadNzOyj_hpX_KNiw_1753173042
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-456267c79deso17471305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753173042; x=1753777842;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiYxraNy+bvn6efAc9zLaMPBsRjqwvrvbjsSdMT2p58=;
        b=u+lDNIeuH+E5+UYNkONQhNLHEhOW/DjGweZWyq/Hlw3ip64/an23vb/Di5fQHFPNvI
         rezHBQW6O82YFW1RicqYFSB5H++oId61GuC9G7YsKw6W4916R1LkGV541ZLWl8Prv3yc
         IXMXM2pcaYdUnlcX9mj5JxwSbec91TEFcD+dn+MeYczF1x9Hb86xQUMTk9jHL3mSo5J9
         mn8mCeXUZkuQYjML5UvNnYuj3vzGDYnAlF58K9sTOjpR5rB/XYosPH80uM3ibfJgSi8e
         U1B8ZaME3XweCFwwUwdafT1SCK4SA7fZCuvrD6oHBGlqrfEz70q+YdWI14T458uTqmyw
         Kp9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyUIkXVI2XYrezbEEDLmCeZvGxwb1Ut4GKfxjpZp+B4+YD9lBLTw0f9u3P4KvycWDHD1vUal2UTviadzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhPLaOcuQQQ9BNseQBzte2OinXVEz9GtXz0DB8xrwDv/bRCkS
	d1r8g2NOtJphXQk49pVvV8T6VV/cVwHxyYR1NVjFpzpFnCPA1a7+smReAIpgf/wkHZGdpPLd1Zg
	w3AjUl5Lrynx2ktS9Lv9H3pH4v3sb4mOM3HC3IENcefzoDsvexmT8sm1GqBCxf8OINQ==
X-Gm-Gg: ASbGncsyfikHSEAjXyQ3hOFmingcoXtb/Dfh5aLMjpObABILsgvxNLg2j5HHafgQWGl
	5CpXAwJRJ9FcCSJ+5qmw1bTLCp3f8xcvBtyr74clWYKPZwuf4oFESpopMV9AAeZ+pXiP2ebzEFC
	OZHRBH+KrpFffsCaB5Bn5vCXyPfe8gkoDY+VYrFNyqnC1jPN29mwNt/x9R+GtElBYB/YFU5dJ8h
	Sl3YZNW/4AE/OBAOnQl/Z0EL/bnji/ppRztY7FzRUfs5BmNM3r78iLL9v5KAifMNjUFkRek8AUc
	QcpC4N51w+Z85UChWdTB+nxn1VfyVeshflWhKIjiHMIlpj7u8seqrUKBi5Pq340cHg==
X-Received: by 2002:a05:600c:4709:b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-4562e379f80mr220963315e9.3.1753173042407;
        Tue, 22 Jul 2025 01:30:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGWUbHXE64+JIbc1psRBua8Ih3NqnkWKbU691zIYC/x16+2NNJqu/u4RN+P0cSm668Iu0SmQ==
X-Received: by 2002:a05:600c:4709:b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-4562e379f80mr220963015e9.3.1753173041968;
        Tue, 22 Jul 2025 01:30:41 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802afasm182592635e9.12.2025.07.22.01.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:30:41 -0700 (PDT)
Message-ID: <0e05cce85c4f2c44123a52bd909a555d98fda8a5.camel@redhat.com>
Subject: Re: [PATCH 4/6] rv: Remove rv_reactor's reference counter
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Jul 2025 10:30:39 +0200
In-Reply-To: <20250722082740.a0kYzRv_@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <4ebe4d49e07890eadae41da233e111f8723fba12.1753091084.git.namcao@linutronix.de>
	 <2de814842fbbeee888e076db2f80bf2028fdbb0d.camel@redhat.com>
	 <20250721140425.OeD16I4D@linutronix.de>
	 <eabfae8b0f29c88437cc51af21797e869d99aef6.camel@redhat.com>
	 <20250722082740.a0kYzRv_@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 10:27 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 05:49:02PM +0200, Gabriele Monaco wrote:
>=20
> > Also, I'd need to verify this but depending on the order of exit
> > functions, we might be seeing the same problems with built-in
> > reactors when active on shutdown. I'm going to play a bit with this
> > and see if this workaround of not deleting the reactor was
> > introduced for that (I doubt though).
>=20
> I'm not sure I follow. exit functions are never called for built-in
> reactors. They are even discarded out of the built image.
>=20

You're right, was tripping, ignore what I just said..

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele


