Return-Path: <linux-kernel+bounces-840846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F100BB58CE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 00:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6A014E37C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 22:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1E427A92E;
	Thu,  2 Oct 2025 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gimpelevich-san-francisco-ca-us.20230601.gappssmtp.com header.i=@gimpelevich-san-francisco-ca-us.20230601.gappssmtp.com header.b="qyJkP3IA"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81CF266B6F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444697; cv=none; b=BmIQrW1QpAkSsIuHRVJVdNnKxIUXzwSpfKWqx7DuA+oa6Tfth/UqzbuqSPW8hC4jCAdG9UreFsq2vy67oYWNHZgrhbmGDaT5/BRSL927Te0Q7SwemMnwn+Q8ijpfCzfz71D+kCFUgi4i1dpWRd4jxFL2x+NVDBOAjQiJjCEKGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444697; c=relaxed/simple;
	bh=XC0sO2N0d+uo0Arvt22e4w8FJtUrLDpvY+BPCwyRgx4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=TXBOPRk2E7HwHSD3/XvFIt8sBNVQuNoXjzoWvDUgwh9Nu1BYQNoWvYvrgcRaS3C0DtbnSPqO4h7zigk3kxHFLXzRa1TVZx8I6rmlx2Tdw9Unfis64Gh0xWqPgU2RynLQmBEu3ttsf8hbr1l0ZUlzm2Y9paD0BUhAnutjJ1xrJ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gimpelevich.san-francisco.ca.us; spf=pass smtp.mailfrom=gimpelevich.san-francisco.ca.us; dkim=pass (2048-bit key) header.d=gimpelevich-san-francisco-ca-us.20230601.gappssmtp.com header.i=@gimpelevich-san-francisco-ca-us.20230601.gappssmtp.com header.b=qyJkP3IA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gimpelevich.san-francisco.ca.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimpelevich.san-francisco.ca.us
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2698384978dso11346425ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 15:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20230601.gappssmtp.com; s=20230601; t=1759444695; x=1760049495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:disposition-notification-to
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XC0sO2N0d+uo0Arvt22e4w8FJtUrLDpvY+BPCwyRgx4=;
        b=qyJkP3IAIdi07QDtg0tHsZsArTI/JwcKVM8w9wcSgyDyFQNsZowbLaFY0Otz4lAwTN
         t5H607DUYqcqYdumiEygDEPIi9kAN7FHMN8kE/pGwkOe2lY9zBLnUoMn/+yuRc7JG1ZW
         Ldfag4oEOHJUR9AG1CZ9l+oMWjCvlih9vzaRU+Btq7zv2iiWC9A65VXeEYrNCZtCmWD7
         EtKpuC9Q6ISh/JJdNouATmKY01hJxZsoycWgb/oX68hqYNwCq1xqMmxCNcTSvPoHAf22
         I870jlaS07On4DR9s0i23PXDWtRzpyfwijlESzjf4N0F2SljNHO1LtlpV59DMTLil2QO
         3/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759444695; x=1760049495;
        h=content-transfer-encoding:mime-version:disposition-notification-to
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XC0sO2N0d+uo0Arvt22e4w8FJtUrLDpvY+BPCwyRgx4=;
        b=BtbFllT2jr1mwbErMs+Er9A11Ek40tPRZ0oxC8dBcNLsT+cEAM00+U6VEDbNrdhjlp
         Cj9ij9BYCW/5rbhyh6q7VxdXFxa6M2edUgFK7nYCN39gCMS+b31Rcd7c/BdYA//iQ9CI
         RBORmokSsC4XZQL2ag+ZB5uueY0tbx3gU6yBWTOfT1MK250iTWlYIhS3g9qpMb8x/qmG
         ExgaM+EtyM2idcghYFprYWLxo05niAw0ObPcMicPX45BzHwF/DYU0sZgNI5GAA9gQ762
         2WbLRBDnH46kqPaUr3ksng5lwfxYWPp7jeamed9NCXWnXENxawleGEJ8I92sSikZ94C/
         Xw5g==
X-Forwarded-Encrypted: i=1; AJvYcCVz170e+AvfHUckM9rsi63rAuoKqyILGbZVjoDpZzoxkNAgPjzP+yu4yvq6mNZET6hlMBA9PXw7QwPdqL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwcj1kemm7esR276zUG9Cgm+9d+wafwGze5LZIKagsD1xJ1yq
	z2kpeNaJESwdENsRRjbcuJBtuxhUDRudpr6RySHUpDHglWKBiA+YeBE8OFv2p/3KhQ==
X-Gm-Gg: ASbGncvuDkd5AH/u8VzKkqtG6a5g032eZapaImGTtVXPMiArTFxJpCh5ojhVTp9PNpu
	2eBWHqKE2FicOrxZg5gzZrXLqlnfo6RDcl0Nmn+0sb9z38QR51pjYS1EzojrOVmRs4EW2asW6f8
	JZawIHdAlOAe0w0PRwlRRuKXsjgSDU20Go8id5VVfFmX5zluQkvRXQGG6qHnQg+lieLs35jM65C
	YrzxG8nOmMmotVWa7P02Jz5CSgubRcekVuFWRx8xtCpB/z35vIzFBZ/Xs/xwF/Gq1Oe/Q9KguN8
	MGJ/pW+W35tOp7+FNJO7C/nfAN2BpbgYqsPrD/77B+5cUckaQysqL12RQFovQPBghqtyyFtxG47
	Phbbu4KGYiENfdi9LIlhvtaigy5v7fQ+8RV3By+MeOgyJlU0AoL6fyzY/D6HwvXd0Che/eNDgX+
	QniI+niGtKjZXFrvCIEB9N74TRjMeiB6XmoaxxQztRnxU=
X-Google-Smtp-Source: AGHT+IGEWpLAS0bs92zaBuI97EwGsBxqAWGzNiljhk82StCYnXBLZ6FnmN8hBjn83V3/i2Ef8tUENg==
X-Received: by 2002:a17:902:d544:b0:25c:d4b6:f111 with SMTP id d9443c01a7336-28e9a65258fmr10877855ad.47.1759444694910;
        Thu, 02 Oct 2025 15:38:14 -0700 (PDT)
Received: from ?IPv6:2001:5a8:429d:2100:4825:53c7:1977:212e? ([2001:5a8:429d:2100:4825:53c7:1977:212e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b9e5asm31046705ad.74.2025.10.02.15.38.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 15:38:14 -0700 (PDT)
Message-ID: <1759444692.24579.8.camel@chimera>
Subject: Re: [PATCH 6/8] CMDLINE: x86: convert to generic builtin command
 line
From: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Daniel Walker (danielwa)" <danielwa@cisco.com>, Will Deacon
 <will@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Rob
 Herring <robh@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Pratyush Brahma <quic_pbrahma@quicinc.com>, Tomas Mudrunka
 <tomas.mudrunka@gmail.com>, Sean Anderson <sean.anderson@seco.com>,
 "x86@kernel.org" <x86@kernel.org>, "linux-mips@vger.kernel.org"
 <linux-mips@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>, Ruslan
 Ruslichenko <rruslich@cisco.com>,  Ruslan Bilovol
 <ruslan.bilovol@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Thu, 02 Oct 2025 15:38:12 -0700
In-Reply-To: <a2be781f-96b5-47d1-81fa-b20395ca293a@intel.com>
References: <20231110013817.2378507-1-danielwa@cisco.com>
	 <20231110013817.2378507-7-danielwa@cisco.com>
	 <00c11f75-7400-4b2a-9a5d-10fc62363835@intel.com> <aN7n_5oiPjk-dCyJ@goliath>
	 <c8b65db3-a6cf-479d-9a83-23cbc62db1ef@intel.com> <aN7vKgcUeQgCFglQ@goliath>
	 <a2be781f-96b5-47d1-81fa-b20395ca293a@intel.com>
Disposition-Notification-To: daniel@gimpelevich.san-francisco.ca.us
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-10-02 at 14:55 -0700, Dave Hansen wrote:
> That's not a bad idea. Or, even if you can pick two amenable
> architectures to start with it will make it really obvious that this is
> useful. Two architectures means a *lot*, IMNHO. Two is a billion times
> better than one.

I think it's a bad idea, if I understand it correctly. The patchset
conceptually patches a mechanism of the kernel as a whole, but one which
just so happens to need to be implemented separately for each arch.
Breaking it down like you suggest creates an embarrassingly high
likelihood of different architectures' implementations of it going out
of sync, a previous situation that this patchset was partly intended to
address. I say keep it atomic. If it breaks on an arch or two but not
others and nobody notices right away, that would be better addressed
with a new patch when someone eventually does notice. Just my 2¢…


