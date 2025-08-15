Return-Path: <linux-kernel+bounces-770084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A1DB27698
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC53ACA25
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B19B29D29D;
	Fri, 15 Aug 2025 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoZWQmH+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6191F1302;
	Fri, 15 Aug 2025 03:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227572; cv=none; b=dYBArkKUrl3nVx1tGXdGyt4qZqwy1K+2SH/cCp9J3poP9kzP5NpKFwxFlPDNfNssSzK7TElzeR7b5sFtlwnjXvVtE1JCL75WWhZ64zO9+sJ1+n08tq70QqCIsOqnNmakkO9vNfJVNcXGRYtW7f605bsApb9KeRd9Aml2dJQ7/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227572; c=relaxed/simple;
	bh=YsEDhpiQu05cFEIH2kVfWAb7P2ooH9l6nt2L+56tavM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qhSiYKH0UIKfr7hZa1fEofc9TM6K+nc/te9533HR3yKXFeqIt6wUFtHyE04srGbTQ0PQnEj1UWW/r4EkhizLCPlbeRfZQLkpZFm/dAsCjAQ0w77uC9USVgMDYxj1iGgcP+9e2E23K17/QTcinzNu9Dk9/fQ5QERLGWOuUzbHraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoZWQmH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48DEC4CEED;
	Fri, 15 Aug 2025 03:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755227572;
	bh=YsEDhpiQu05cFEIH2kVfWAb7P2ooH9l6nt2L+56tavM=;
	h=From:To:Cc:Subject:Date:From;
	b=IoZWQmH+xAXJ4szSnsB+t4diKW7Sn7Pkpj4ga2o8MKDn2Hs4bXnHvj58ePVw5Ormf
	 6rGul3TCWfZX3zY1duNwjlvZxyWdKHoFsqhCdtphwHHWdE3yMtdfsYuH3r5qWPip5I
	 iJHan41lnDXyTpfTuNN6rRJluvV1CuJbDq4x7QRLIxHPu7euG81nN+RlyOTrZhzV7F
	 SdjQnXfo/B+eMbddMcnbaSnK87WQnBgJM9tPb509CWHOKZjilnQlgkgD+MilhrYAgb
	 IRF/cilwpgthSv3MenIu0k70TdCNaqCe8edvZ31nCbBwBELk4Obb8+ikOaT5xhPSNc
	 04IopRkojfIeg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] usb: usb251xb: support usage case without I2C control
Date: Fri, 15 Aug 2025 10:55:38 +0800
Message-ID: <20250815025540.30575-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor so that register writes for configuration are only performed if
the device has a i2c_client provided and also register as a platform
driver. This allows the driver to be used to manage GPIO based control
of the device.

Jisheng Zhang (2):
  dt-bindings: usb: usb251xb: make reg optional for no I2C ctrl use case
  usb: usb251xb: support usage case without I2C control

 .../devicetree/bindings/usb/usb251xb.yaml     |   1 -
 drivers/usb/misc/usb251xb.c                   | 108 +++++++++++++++---
 2 files changed, 94 insertions(+), 15 deletions(-)

-- 
2.50.0


