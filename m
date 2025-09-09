Return-Path: <linux-kernel+bounces-808984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC0B50724
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEC03A8117
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CE73570CF;
	Tue,  9 Sep 2025 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenoble-inp.org header.i=@grenoble-inp.org header.b="BCtBrI98"
Received: from smtpout01-ext2.partage.renater.fr (smtpout01-ext2.partage.renater.fr [194.254.240.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA02FD1B6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.240.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450030; cv=none; b=sfMlDBSm+CBW8OMbAjYxVdALWyrvrNAW/eBrRi9wo+6Y9m6xt0AAu3xIKQ9wtTQM0CoHX+THWHx8XqGza+3I8RjmZAKY4yLRRtcDFxmufVyOK11F5yXKEKhk5OjG9NbX+ECBrRhPj+EDyjvts7JXnCrYJdou9oOXE+pXVXISjBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450030; c=relaxed/simple;
	bh=yq6xPpkW9blIYWjrt3urU0YFEqfdkmIhGv3QpePmGhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLHKIT7ofU8c9JWBhHtwhdNXw423nbqOZh895c44T5Ea4t81Avn/ZRFB6UVc2X2HFft7QD63XxDiA9bM822BcClBFohuLd/uJLb22omMT1o26UZ09CPyoxskRao0o+zbZ/gY4IXoTbmqXbxNOcHM3QNBgLpYNiDWytHpPRCjKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grenoble-inp.org; spf=none smtp.mailfrom=grenoble-inp.org; dkim=pass (2048-bit key) header.d=grenoble-inp.org header.i=@grenoble-inp.org header.b=BCtBrI98; arc=none smtp.client-ip=194.254.240.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grenoble-inp.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=grenoble-inp.org
Received: from zmtaauth03.partage.renater.fr (zmtaauth03.partage.renater.fr [194.254.240.26])
	by smtpout10.partage.renater.fr (Postfix) with ESMTP id 529D06461B;
	Tue,  9 Sep 2025 22:26:37 +0200 (CEST)
Received: from zmtaauth03.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTPS id 44E1D8000B;
	Tue,  9 Sep 2025 22:26:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTP id 3396F800EF;
	Tue,  9 Sep 2025 22:26:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth03.partage.renater.fr 3396F800EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble-inp.org;
	s=F42A61D9-9621-4693-8E8E-830FB5F1ED6E; t=1757449597;
	bh=Buy1T95uIc1Zz/z/TPg/PIi9MThQ2QqgRVzaijMTRzc=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=BCtBrI98qZFR5d26ZdPzSYuNyTP3Qj39LmHzt2+aZXr9/RK85xHIJeLzOzEWzFEsu
	 QO4AtLgMMpiDJhFqohuZvzcNPKtiFYgpWBRltPagJZgr3q84L/tn6rX0l0L45XcyW4
	 XLiFCs8P9FxHeKPGnzSihW4Bjrb3nGTzPh07oiE6BvlBttt7Gflc1+gkS9/mjG9OjQ
	 LiLpg63heukcUeZh14ox/B1AewOBaHePq8+3TXQPApoG6HE5Cfz+/dWRY364M6uxoy
	 5sQZHqFCmW5X7KBPJ0WD7jli0WdKe1qr6+jDDCQ/+M/fc+IeY2tm8BhvROq4tZ7h1U
	 Jl30XShobUJ1A==
Received: from zmtaauth03.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth03.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id QhnL2tjYwYpB; Tue,  9 Sep 2025 22:26:37 +0200 (CEST)
Received: from 91.166.147.41 (unknown [194.254.241.250])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTPA id B41C980048;
	Tue,  9 Sep 2025 22:26:36 +0200 (CEST)
From: Calixte Pernot <calixte.pernot@grenoble-inp.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Calixte Pernot <c@lixte.email>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>
Subject: [PATCH v3] vt: add support for smput/rmput escape codes
Date: Tue,  9 Sep 2025 22:26:30 +0200
Message-ID: <20250909202629.9386-2-calixte.pernot@grenoble-inp.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <5002d4f9-4999-4a84-9329-edb20098fd7a@gmail.com>
References: <5002d4f9-4999-4a84-9329-edb20098fd7a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.12 at clamav02
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucftgffptefvgfftnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevrghlihigthgvucfrvghrnhhothcuoegtrghlihigthgvrdhpvghrnhhothesghhrvghnohgslhgvqdhinhhprdhorhhgqeenucggtffrrghtthgvrhhnpeevvdejheegvdfgffevhffgiedthfffjefggfeuudevteduveeuueehueekteejjeenucfkphepudelgedrvdehgedrvdeguddrvdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleegrddvheegrddvgedurddvhedtpdhhvghlohepledurdduieeirddugeejrdeguddpmhgrihhlfhhrohhmpegtrghlihigthgvrdhpvghrnhhothesghhrvghnohgslhgvqdhinhhprdhorhhgpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgeslhhigihtvgdrvghmrghilhdprhgtphhtthhopegtrghlihigthgvrdhpvghr
 nhhothesghhrvghnohgslhgvqdhinhhprdhorhhg
Content-Transfer-Encoding: quoted-printable

From: Calixte Pernot <c@lixte.email>

Support "\e[?1049h" and "\e[?1049l" escape codes.
This patch allows programs to enter and leave alternate screens.
This feature is widely available in graphical terminal emulators and most=
ly
used by fullscreen terminal-based user interfaces such as text editors.
Most editors such as vim and nano assume this escape code in not supporte=
d
and will not try to print the escape sequence if TERM=3Dlinux.
To try out this patch, run `TERM=3Dxterm-256color vim` inside a VT.

Signed-off-by: Calixte Pernot <calixte.pernot@grenoble-inp.org>
---
 drivers/tty/vt/vt.c            | 58 ++++++++++++++++++++++++++++++++++
 include/linux/console_struct.h |  3 ++
 2 files changed, 61 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 62049ceb3..d9e4eb3f0 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -141,6 +141,7 @@ static const struct consw *con_driver_map[MAX_NR_CONS=
OLES];
 static int con_open(struct tty_struct *, struct file *);
 static void vc_init(struct vc_data *vc, int do_clear);
 static void gotoxy(struct vc_data *vc, int new_x, int new_y);
+static void restore_cur(struct vc_data *vc);
 static void save_cur(struct vc_data *vc);
 static void reset_terminal(struct vc_data *vc, int do_clear);
 static void con_flush_chars(struct tty_struct *tty);
@@ -1344,6 +1345,10 @@ struct vc_data *vc_deallocate(unsigned int currcon=
s)
 		kfree(vc->vc_screenbuf);
 		vc_cons[currcons].d =3D NULL;
 	}
+	if (vc->vc_saved_screen !=3D NULL) {
+		kfree(vc->vc_saved_screen);
+		vc->vc_saved_screen =3D NULL;
+	}
 	return vc;
 }
=20
@@ -1878,6 +1883,45 @@ static int get_bracketed_paste(struct tty_struct *=
tty)
 	return vc->vc_bracketed_paste;
 }
=20
+/* console_lock is held */
+static void enter_alt_screen(struct vc_data *vc)
+{
+	unsigned int size =3D vc->vc_rows * vc->vc_cols * 2;
+
+	if (vc->vc_saved_screen !=3D NULL)
+		return; /* Already inside an alt-screen */
+	vc->vc_saved_screen =3D kmemdup((u16 *)vc->vc_origin, size, GFP_KERNEL)=
;
+	if (vc->vc_saved_screen =3D=3D NULL)
+		return;
+	vc->vc_saved_rows =3D vc->vc_rows;
+	vc->vc_saved_cols =3D vc->vc_cols;
+	save_cur(vc);
+	/* clear entire screen */
+	csi_J(vc, CSI_J_FULL);
+}
+
+/* console_lock is held */
+static void leave_alt_screen(struct vc_data *vc)
+{
+	unsigned int rows =3D min(vc->vc_saved_rows, vc->vc_rows);
+	unsigned int cols =3D min(vc->vc_saved_cols, vc->vc_cols);
+	u16 *src, *dest;
+
+	if (vc->vc_saved_screen =3D=3D NULL)
+		return; /* Not inside an alt-screen */
+	for (unsigned int r =3D 0; r < rows; r++) {
+		src =3D vc->vc_saved_screen + r * vc->vc_saved_cols;
+		dest =3D ((u16 *)vc->vc_origin) + r * vc->vc_cols;
+		memcpy(dest, src, 2 * cols);
+	}
+	restore_cur(vc);
+	/* Update the entire screen */
+	if (con_should_update(vc))
+		do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
+	kfree(vc->vc_saved_screen);
+	vc->vc_saved_screen =3D NULL;
+}
+
 enum {
 	CSI_DEC_hl_CURSOR_KEYS	=3D 1,	/* CKM: cursor keys send ^[Ox/^[[x */
 	CSI_DEC_hl_132_COLUMNS	=3D 3,	/* COLM: 80/132 mode switch */
@@ -1888,6 +1932,7 @@ enum {
 	CSI_DEC_hl_MOUSE_X10	=3D 9,
 	CSI_DEC_hl_SHOW_CURSOR	=3D 25,	/* TCEM */
 	CSI_DEC_hl_MOUSE_VT200	=3D 1000,
+	CSI_DEC_hl_ALT_SCREEN	=3D 1049,
 	CSI_DEC_hl_BRACKETED_PASTE =3D 2004,
 };
=20
@@ -1944,6 +1989,12 @@ static void csi_DEC_hl(struct vc_data *vc, bool on=
_off)
 		case CSI_DEC_hl_BRACKETED_PASTE:
 			vc->vc_bracketed_paste =3D on_off;
 			break;
+		case CSI_DEC_hl_ALT_SCREEN:
+			if (on_off)
+				enter_alt_screen(vc);
+			else
+				leave_alt_screen(vc);
+			break;
 		}
 }
=20
@@ -2182,6 +2233,13 @@ static void reset_terminal(struct vc_data *vc, int=
 do_clear)
 	vc->vc_deccm		=3D global_cursor_default;
 	vc->vc_decim		=3D 0;
=20
+	if (vc->vc_saved_screen !=3D NULL) {
+		kfree(vc->vc_saved_screen);
+		vc->vc_saved_screen =3D NULL;
+		vc->vc_saved_rows =3D 0;
+		vc->vc_saved_cols =3D 0;
+	}
+
 	vt_reset_keyboard(vc->vc_num);
=20
 	vc->vc_cursor_type =3D cur_default;
diff --git a/include/linux/console_struct.h b/include/linux/console_struc=
t.h
index 59b4fec5f..13b35637b 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -159,6 +159,9 @@ struct vc_data {
 	struct uni_pagedict *uni_pagedict;
 	struct uni_pagedict **uni_pagedict_loc; /* [!] Location of uni_pagedict=
 variable for this console */
 	u32 **vc_uni_lines;			/* unicode screen content */
+	u16		*vc_saved_screen;
+	unsigned int	vc_saved_cols;
+	unsigned int	vc_saved_rows;
 	/* additional information is in vt_kern.h */
 };
=20
--=20
2.51.0


