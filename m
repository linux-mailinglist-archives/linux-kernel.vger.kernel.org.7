Return-Path: <linux-kernel+bounces-811713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039ABB52CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715E05865AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72F2E8DE2;
	Thu, 11 Sep 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5wW6v4L"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F992E54B6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582250; cv=none; b=k7JGPKpdfFAO33B7tglp5cCG7D0Y7yJ3WRNO8swBY36lBz4RuAUVm3gjt/t6FiKm5YlHRjJ3d5tryo1nzPv+N8x76OK4RLScrRQt8/wAQW+PIWf09uwqusFdmoBCCkx9Juv9ceL9nVAZdx9JePL3Kc7KioQoNDiRq/huj4mwXsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582250; c=relaxed/simple;
	bh=nRopOZdLmoabNyUraQZ8tWhkKnKT00UAZalz8gNlCrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY6eFp+bIqf5LgedmVVtBGU+sivZ6Nm5V0RYXEM3OQwZyBxhsaFT5uXopiVoywtryq18uxDnG3HXhM2jQC1HkT+zW3LWJOsFg3sYTtjdhZzNhGn4JX5MbmqP4b3eB1d+D4EyvkDd5a3Gt1XTcwyd9OqlIp3F/VN359NVxGncNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5wW6v4L; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32d3e17d927so480898a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757582249; x=1758187049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbW2IpP4iJhEkSOGqFGCsK7hlxWafH505HiZGCidKuM=;
        b=H5wW6v4Ld7Ynys29TQDzmqVTzS/s/pNEIURnQJHajBOe97UPZ+hHsE17C4QNa2dpid
         QyP2Oa0Oro/rvtZoqTa1KfKlzhvez5Od1gDZzc7lDBUE1/XLQvdJxJ4PiAux1Jid/xpH
         Dca85sF1yEUE8OphXktcpXtDRYUeRfaPK41iNf3ulsl9ivGUHCZtjZxJfrDWeeHT1BxI
         1FGErLGX7fwBmzQ3sFuptl0BPnfJOdcWvnB23puxOmVG7Oo/PUKG5WiBKuBQc2sQ7jrW
         3MXk4EVj5M/LGZsvrW7iiF5/U0O7lAp1cP/gGnLKHHyOWKohL6ligV4vTMk0fIwIpoUb
         wsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582249; x=1758187049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbW2IpP4iJhEkSOGqFGCsK7hlxWafH505HiZGCidKuM=;
        b=YzP47p3cU19nOQNvf4jvFMMX0LBHRMFPBymHI63aP7DFMlpw9WH6awUj5A9tL9NfXz
         9xPX5y23xP7qZoj3bLKJGi/3WbrnbvoshaBqEi3z5uQ3DXYFrNFzANLHKLAp3rC5jEFf
         n80TbnqeDK6JK5xeM6XPqDpB1qVQNBICVY9zXOcUv56W4EFRABL2129k7LM+4++2r61l
         65jolbxUv0RdE2l4s5s35YJULlvQtdCWoeeATtMuLRbReMdskCFjDlvd47OJtUTssrOD
         HSzohwo1KZFFGQC6e0IJ7C+irkdDOPBDzJ8ZcIFfvAbiScFInFpSaYnFhsNcKRmXSfJL
         uajQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf+ibe2y/TdowBs5gGbbkdFEJ26Pi35KKjAPM2SfEbbEDbbQ6gZzVYf/DdZUEM9nKev03yUFJbbDxqj4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLjlqQvJFrrU+f7ArXRcEMDL7zxvoll7+538ITuFV2ngjPWcS
	uMp6+xUL5Tjk4pYNHW6cMlnxSGQ/U1LsOy0vEFlx7xJgUH7g84h72Lhs
X-Gm-Gg: ASbGnctcQGYPexm6kHi/81E9Qrh/Lv91BXVnoCJK2vcaNN3fxVyf+5xdr4A417VH+I/
	Jp1d9auENJXcaAy1Jaaejgs2cQefOBL3jWYThodWhnlvD3Zv6VH7nlkO7/Wst0FCKe5De6LxO33
	DL/FBNgKyBY6w1iJgjmVCVTzab5LEhy5qBIjaBwYxAFEA5i9zo55ibMrNgicG5ydiplpk8LAYbY
	0KNoD0AfdqQESYyTt9cP4PSRDPCvv0xPy4FRftBpf771MgSZxOiCZm8UFIjuH5h0IdK1GmuslaW
	ZAp2s5XBEhlFB28SEK/pX8smru8g6wUTAB/TMrQEwfrRfR2SsNdBzfkr4Lzp+gUE0AfX4DEe9mT
	DjsIVYK8zrVodBTdwHbKc0+wCU6DCnVrT26sLFppcnrMT
X-Google-Smtp-Source: AGHT+IGdNYE+dmhUuvc/wFgrZNzzmv3OTe5tjvhzE/L0vEbZy87456Q+ZpSrek0dlXJ+tGug6w7OBg==
X-Received: by 2002:a17:90b:1dc1:b0:32b:5c13:868d with SMTP id 98e67ed59e1d1-32d43ef6d63mr22709012a91.1.1757582248622;
        Thu, 11 Sep 2025 02:17:28 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd632377fsm1942431a91.23.2025.09.11.02.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:17:28 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: hch@infradead.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH v3 0/4] allow partial folio write with iomap_folio_state
Date: Thu, 11 Sep 2025 17:17:26 +0800
Message-ID: <20250911091726.1774681-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aK20jalLkbKedAz8@infradead.org>
References: <aK20jalLkbKedAz8@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 06:20:13 -0700, Christoph Hellwig wrote:
> On Mon, Aug 26, 2025 at 07:39:21PM +0800, Jinliang Zheng wrote:
> > Actually, I discovered this while reading (and studying) the code for large
> > folios.
> > 
> > Given that short-writes are inherently unusual, I don't think this patchset
> > will significantly improve performance in hot paths. It might help in scenarios
> > with frequent memory hardware errors, but unfortunately, I haven't built a
> > test scenario like that.
> > 
> > I'm posting this patchset just because I think we can do better in exception
> > handling: if we can reduce unnecessary copying, why not?
> 
> I'm always interested in the motivation, especially for something
> adding more code or doing large changes.  If it actually improves
> performance it's much easier to argue for.  If it doesn't that doesn't
> mean the patch is bad, but it needs to have other upsides.  I'll take
> another close look, but please also add your motivation to the cover
> letter and commit log for the next round.

Okay, I'll try my best to clarify the motivation in my future patches.

Also, have you found any issues with this patchset in the past two weeks? If so,
please let me know. And I'd be happy to improve it.

Alternatively, would you mind accepting this patchset? :)

thanks,
Jinliang Zheng. ;)

