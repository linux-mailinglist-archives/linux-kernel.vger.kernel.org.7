Return-Path: <linux-kernel+bounces-870250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028FBC0A491
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8869F3AD99D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746FB273809;
	Sun, 26 Oct 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM9JNjjn"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7174B23D7D2
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761467158; cv=none; b=b1RffcBiMMwYBq3isEVmJbYEsKvvuNSfXwc9Cqx8oDExOXMXkQuIkGugokGLRb2PCuTCTLSL2m+V6ZUeZlshDF4r4HNo+/50v2KhwPm0IE7GwvrN6TXr13DWZ5qm8ajAHAXJitq2Q6gdZsqmBg/2fj5h+tP5GIEF6WXhJzLxVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761467158; c=relaxed/simple;
	bh=WCD8R9xQBmmQFqaX0VCtflgMfkv8o2xCOmmKnuUd9A0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Strbaj5Xuz6lU02HHkyz0HPuG/ARshQ+X24iUhaOoj5z9bJNqJ1ADbXOCRymAYBd5f7GkYvQfOnn06MHAfIhpAejzMJHMz71dRqew1Mi/ORGB4b8Y3ZD5EYpKE0HBzEIXsE4d3sSnqswcgVL4+T+IemFhIl11SkvakeEZKSxx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fM9JNjjn; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-430da72d67bso23083005ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761467156; x=1762071956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WCD8R9xQBmmQFqaX0VCtflgMfkv8o2xCOmmKnuUd9A0=;
        b=fM9JNjjnFm04p48qC7fkDr2CxQaouwjDn3F6CFSNAl6dJOgzmEx8puptMj3Sa4jhEs
         8gJeFeRvUvJDVUVfE1rsMLz6Vgohj60mAo8ZjI+wGM1BWGFSmZlmAlujx5Y8SWMwmyeH
         I6+vvXP/ashnlC57oDbF3MaUDNf4toDDvbsBOS7+hfXhbKff+ImTLgwkg7Vfz0i/PYZZ
         Tbpj1hggA8UnhNonF9MC50CZVvJ0iBZOdQVIXY/VRjiJmmoQb0D6F/oKQ3osn6FXrQei
         Kg7c7JP7T6fRdbbR1HR/0pKmAW+s9kYh1WgGF9nnq6umKuEyZfmZNzEuuNkiGQ5f8D67
         bjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761467156; x=1762071956;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCD8R9xQBmmQFqaX0VCtflgMfkv8o2xCOmmKnuUd9A0=;
        b=QOENfr/XEX+tJWoOfXxCJAc4sQ3rPx/ngm2UJG6u0rwfp9Mz5+S0lUf3+yVY7MDnCX
         Zr5Np+yfJH/8z6Uo24C18MkWgjYTk2J5YxS0wvSjcsz5XF3hkc4xkrGiIVWwl+52+Ras
         czhIvG6u070oxQ8hoJC4+djNgIWlb7OAOHv5rHkPR1tJRusuKc/nn8ciMKZcqnuQWCYo
         nSZ36SXkh+JNxk0n7EO03TxM1RLDnMC8W/xX0r+OGCm0CUTPQv5BELPQ45C+ceS0XMZR
         jDF5hbdqQQACgX4cXxljaDrFZcJPv13677qkUJnKz7z7p7X/1/521BvCBpIJp+y3C6Gv
         diNA==
X-Gm-Message-State: AOJu0Yw5u/Y7B+axwOPvYWvM8KK0y8lHXOXF+Vh9TVAu3n/78VEE1ZI3
	zB7CuTvqXhMuXDCvdJC+vH9e8QvWpHkZgSpykEOyTuy0rvQzjOsYeHnnhAy17+TFDKSIFjzKu9G
	C9sIpEfUxpvLe8gHLKgA2djTFXYHghLBUi0yg
X-Gm-Gg: ASbGnctdQxJSlCkXMgSesa8wf4UanZxDeM/pbwci5rnkOfbmVKX2+n8bIg5AASYb+S1
	ZwXMjS9/qTdZ6QYtw06pdJISULSJJtO8PR5eX8M+U/8vJcx9NZqsdRDZDDiDYGPgmQ6/v9lJ5fN
	xEgjlm/i7TmUJVbOKYcRMpDVn0j/AXyrsFv013dOMK5ipW0AiscDgrfBgsftHjuqlwjX9zoFw+C
	km3/cPhhlGR8Q7GNboWF4o5lMv1Zmf//8XUsw6ksQQr4T2gNw1ivY1TH7WRduVz/vj89qmRzg96
	JJBs5HbEChDVwFtm7PgMbh5aDbIZ
X-Google-Smtp-Source: AGHT+IFsxJE9amyHCf47qG1yTdtWJeGh48qrWBV0CWmqRw7VI5lCUwkL37wBnWACb9bAClDxSvGC11GyYkPWVAOMlAA=
X-Received: by 2002:a05:6e02:1786:b0:430:bf84:e94c with SMTP id
 e9e14a558f8ab-431eb67c444mr85241195ab.13.1761467156231; Sun, 26 Oct 2025
 01:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Sun, 26 Oct 2025 09:25:45 +0100
X-Gm-Features: AWmQ_bkq5DB2z8qpYMPuUopBz_fbj3vbmdg5r6ZMqJt_cZMGQiOfWcDXBtGETT0
Message-ID: <CAB95QARfqSUNJCCgyPcTPu0-hk10e-sOVVMrnpKd6OdV_PHrGA@mail.gmail.com>
Subject: Can't boot kernel 6.17.4+ via rEFInd
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi All,

I've got a problem booting the stable kernel 6.17.4 and 6.17.5 after
updating from 6.17.3 via make oldconfig. Out of my 4 amd64 machines
running Gentoo, two are unable to boot with rEFInd showing "Error: Not
Found while loading <kernel file name>." Bisecting kernel sources
points to commit 5b5cdb1fe434e8adc97d5037e6d05dd386c4c4c6.

All four machines use very similar toolchains: GCC 15.2.0 and
15.2.1_p20251018, binutils 2.45.

https://bugzilla.kernel.org/show_bug.cgi?id=220700 has kernel config attached.

Would appreciate any hints or suggestions.

Best regards,
Eugene

